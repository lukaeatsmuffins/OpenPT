#version 460 core
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
layout(rgba32f, binding = 0) uniform image2D screen;

layout (std140, binding = 0) uniform Camera {
	vec4 pos;
	vec4 u;
	vec4 v;
	vec4 w;

	float vfov;
	float aspect_ratio;
} camera;

layout(location = 0) uniform uint u_frame;
layout(location = 1) uniform uint u_sample_count;

#define MAX_MARCHING_STEPS 500
#define MAX_DISTANCE 100.0
#define MAX_BOUNCES 8
#define EPSILON 0.001

#define BULB_POWER 8.0
#define BULB_ITERATIONS 10
#define BULB_BAILOUT 2.0

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

struct Material {
	vec3 albedo;
	vec3 emission;
};

struct SceneSample {
	float dist;
	Material mat;
};

struct Hit {
	bool hit;
	vec3 pos;
	vec3 normal;
	Material mat;
};

// ---------------------------------------------------------------------------
// Random numbers (PCG hash)
// ---------------------------------------------------------------------------

uint pcg_hash(uint v) {
	uint state = v * 747796405u + 2891336453u;
	uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	return (word >> 22u) ^ word;
}

// Uniform float in [0, 1). Advances the generator state.
float rand(inout uint state) {
	state = pcg_hash(state);
	return float(state >> 8u) * (1.0 / 16777216.0);
}

// Uniformly distributed point on the unit sphere.
vec3 random_unit_vector(inout uint state) {
	float z = rand(state) * 2.0 - 1.0;
	float a = rand(state) * 6.28318530718;
	float r = sqrt(1.0 - z * z);
	return vec3(r * cos(a), r * sin(a), z);
}

// ---------------------------------------------------------------------------
// Scene
// ---------------------------------------------------------------------------

float sdMandelbulb(vec3 p, out float trap) {
	vec3 z = p;
	float dr = 1.0; // running derivative of |z|
	float r = length(z);
	trap = r;

	for (int i = 0; i < BULB_ITERATIONS; ++i) {
		r = length(z);
		if (r > BULB_BAILOUT) {
			break;
		}
		trap = min(trap, r);

		// z = z^power + p, with z^power done in spherical coordinates:
		// radius to the power, both angles times the power.
		float theta = acos(clamp(z.z / r, -1.0, 1.0));
		float phi = atan(z.y, z.x);
		dr = BULB_POWER * pow(r, BULB_POWER - 1.0) * dr + 1.0;

		float zr = pow(r, BULB_POWER);
		theta *= BULB_POWER;
		phi *= BULB_POWER;

		z = zr * vec3(sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta)) + p;
	}

	return 0.5 * log(r) * r / dr;
}

float sdSphere(vec3 p, float r) {
	return length(p) - r;
}

// Union of two shapes: keep whichever is closer, together with its material.
SceneSample opUnion(SceneSample a, SceneSample b) {
	if (a.dist < b.dist) {
		return a;
	}
	return b;
}

SceneSample scene(vec3 p) {
	float trap;
	// the formula's symmetry axis is z, p.xzy makes it point up.
	SceneSample bulb = SceneSample(
		sdMandelbulb(p.xzy, trap),
		Material(vec3(0.5), vec3(0.0)));

	return bulb;
}

float scene_dist(vec3 p) {
	return scene(p).dist;
}

vec3 estimate_normal(vec3 p) {
	const vec2 e = vec2(EPSILON, 0.0);
	return normalize(vec3(
		scene_dist(p + e.xyy) - scene_dist(p - e.xyy),
		scene_dist(p + e.yxy) - scene_dist(p - e.yxy),
		scene_dist(p + e.yyx) - scene_dist(p - e.yyx)));
}

vec3 sky(vec3 dir) {
	float a = 0.5 * (dir.y + 1.0);
	return mix(vec3(1.0), vec3(0.5, 0.7, 1.0), a);
}

// ---------------------------------------------------------------------------
// Marching and path tracing
// ---------------------------------------------------------------------------

Hit march(vec3 ro, vec3 rd) {
	Hit h = Hit(false, vec3(0.0), vec3(0.0), Material(vec3(0.0), vec3(0.0)));

	float t = 0.0;
	for (int i = 0; i < MAX_MARCHING_STEPS && t < MAX_DISTANCE; ++i) {
		vec3 p = ro + t * rd;
		SceneSample s = scene(p);
		if (s.dist < EPSILON) {
			h.hit = true;
			h.pos = p;
			h.normal = estimate_normal(p);
			h.mat = s.mat;
			return h;
		}
		t += s.dist;
	}
	return h; // ran out of steps or distance: miss
}

vec3 trace(vec3 ro, vec3 rd, inout uint rng) {
	vec3 radiance = vec3(0.0);   // light collected so far
	vec3 throughput = vec3(1.0); // how much of the light found later still reaches the camera

	for (int bounce = 0; bounce < MAX_BOUNCES; ++bounce) {
		Hit h = march(ro, rd);

		if (!h.hit) {
			radiance += throughput * sky(rd);
			break;
		}

		radiance += throughput * h.mat.emission;
		throughput *= h.mat.albedo;

		// Start the next ray just off the surface, or it immediately "hits" again.
		ro = h.pos + h.normal * (2.0 * EPSILON);

		// Diffuse bounce. Guard against normal + random vector cancelling out.
		vec3 dir = h.normal + random_unit_vector(rng);
		rd = dot(dir, dir) > 1e-12 ? normalize(dir) : h.normal;
	}

	return radiance;
}

// ---------------------------------------------------------------------------

void main() {
	ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);
	ivec2 dims = imageSize(screen);

	// The dispatch is rounded up to whole 8x8 groups, so skip threads outside the image.
	if (any(greaterThanEqual(pixel_coords, dims))) {
		return;
	}

	// Different seed for every pixel and every frame.
	uint rng = pcg_hash(uint(pixel_coords.y * dims.x + pixel_coords.x));
	rng = pcg_hash(rng + u_frame);

	float x = float(pixel_coords.x * 2 - dims.x) / dims.x; // [-1, 1]
	x *= float(dims.x) / float(dims.y);                    // aspect ratio
	float y = float(pixel_coords.y * 2 - dims.y) / dims.y; // [-1, 1]

	float d = 1.0 / tan(radians(camera.vfov) / 2.0);
	vec3 local = vec3(x, y, -d);

	vec3 ray_o = camera.pos.xyz;
	vec3 ray_d = normalize(mat3(camera.u.xyz, camera.v.xyz, camera.w.xyz) * local);

	vec3 average = trace(ray_o, ray_d, rng);
	if (u_sample_count > 0u) {
		vec3 previous = imageLoad(screen, pixel_coords).rgb;
		average = mix(previous, average, 1.0 / float(u_sample_count + 1u));
	}
	imageStore(screen, pixel_coords, vec4(average, 1.0));
}
