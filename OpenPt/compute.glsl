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
	float aperture;
	float focal_length;
} camera;

layout (std140, binding = 1) uniform Settings {
	vec4 glow_color; // rgb used
	float glow_start;
	float glow_end;
	float glow_intensity;
	float sky_intensity;
	float max_distance;
	int max_bounces;
	int max_steps;
	float epsilon;
	float bulb_power;
	int bulb_iterations;
	float bulb_bailout;
} settings;

layout(location = 0) uniform uint u_frame;
layout(location = 1) uniform uint u_sample_count;

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

vec2 random_in_unit_disk(inout uint state) {
	float r = sqrt(rand(state)); // sqrt: otherwise points bunch up in the center
	float a = rand(state) * 6.28318530718;
	return r * vec2(cos(a), sin(a));
}

// ---------------------------------------------------------------------------
// Scene
// ---------------------------------------------------------------------------

float sdMandelbulb(vec3 p, out float trap) {
	vec3 z = p;
	float dr = 1.0; // running derivative of |z|
	float r = length(z);
	trap = r;

	for (int i = 0; i < settings.bulb_iterations; ++i) {
		r = length(z);
		if (r > settings.bulb_bailout) {
			break;
		}
		trap = min(trap, r);

		// z = z^power + p, with z^power done in spherical coordinates:
		// radius to the power, both angles times the power.
		float theta = acos(clamp(z.z / r, -1.0, 1.0));
		float phi = atan(z.y, z.x);
		dr = settings.bulb_power * pow(r, settings.bulb_power - 1.0) * dr + 1.0;

		float zr = pow(r, settings.bulb_power);
		theta *= settings.bulb_power;
		phi *= settings.bulb_power;

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

vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
	return a + b * cos(6.28318530718 * (c * t + d));
}

SceneSample scene(vec3 p) {
	float trap;

	float dist = sdMandelbulb(p.xzy, trap);
	
	float t = clamp(pow(trap, 2.0), 0.0, 1.0);

	vec3 albedo = 0.8 * palette(t, vec3(0.5, 0.35, 0.2), vec3(0.5, 0.35, 0.2), vec3(1.0), vec3(0.0, 0.05, 0.1));

	float glow = 1.0 - smoothstep(settings.glow_start, settings.glow_end, trap);
	vec3 emission = settings.glow_color.rgb * settings.glow_intensity * glow;

	return SceneSample(dist, Material(albedo, emission));
}

float scene_dist(vec3 p) {
	return scene(p).dist;
}

vec3 estimate_normal(vec3 p) {
	const vec2 e = vec2(settings.epsilon, 0.0);
	return normalize(vec3(
		scene_dist(p + e.xyy) - scene_dist(p - e.xyy),
		scene_dist(p + e.yxy) - scene_dist(p - e.yxy),
		scene_dist(p + e.yyx) - scene_dist(p - e.yyx)));
}

vec3 sky(vec3 dir) {
	float a = clamp(dir.y * 0.5 + 0.5, 0.0, 1.0);
	vec3 horizon = vec3(0.020, 0.025, 0.040);
	vec3 zenith  = vec3(0.002, 0.002, 0.005);
	return settings.sky_intensity * mix(horizon, zenith, a);
}

// ---------------------------------------------------------------------------
// Marching and path tracing
// ---------------------------------------------------------------------------

Hit march(vec3 ro, vec3 rd) {
	Hit h = Hit(false, vec3(0.0), vec3(0.0), Material(vec3(0.0), vec3(0.0)));

	float t = 0.0;
	for (int i = 0; i < settings.max_steps && t < settings.max_distance; ++i) {
		vec3 p = ro + t * rd;
		SceneSample s = scene(p);
		if (s.dist < settings.epsilon) {
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

	for (int bounce = 0; bounce < settings.max_bounces; ++bounce) {
		Hit h = march(ro, rd);

		if (!h.hit) {
			radiance += throughput * sky(rd);
			break;
		}

		radiance += throughput * h.mat.emission;
		throughput *= h.mat.albedo;

		// Start the next ray just off the surface, or it immediately "hits" again.
		ro = h.pos + h.normal * (2.0 * settings.epsilon);

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

	// different seed for every pixel and every frame.
	uint rng = pcg_hash(uint(pixel_coords.y * dims.x + pixel_coords.x));
	rng = pcg_hash(rng + u_frame);

	// Anti-aliasing: a random point inside the pixel instead of its corner.
	// Accumulation averages these over frames, so no loop is needed.
	vec2 jitter = vec2(rand(rng), rand(rng));
	vec2 pixel = vec2(pixel_coords) + jitter;

	float x = (pixel.x * 2.0 - float(dims.x)) / float(dims.x); // [-1, 1]
	x *= float(dims.x) / float(dims.y);                          // aspect ratio
	float y = (pixel.y * 2.0 - float(dims.y)) / float(dims.y); // [-1, 1]

	float d = 1.0 / tan(radians(camera.vfov) / 2.0);
	mat3 basis = mat3(camera.u.xyz, camera.v.xyz, camera.w.xyz);

	// Unnormalized direction through the image plane, which sits at distance d.
	vec3 dir = basis * vec3(x, y, -d);

	// Depth of field: the point this pixel sees on the focus plane...
	vec3 focus_point = camera.pos.xyz + dir * (camera.focal_length / d);

	// ...is reached from a random point on the lens instead of the camera center.
	vec2 lens = camera.aperture * random_in_unit_disk(rng);
	vec3 ray_o = camera.pos.xyz + lens.x * camera.u.xyz + lens.y * camera.v.xyz;
	vec3 ray_d = normalize(focus_point - ray_o);

	vec3 average = trace(ray_o, ray_d, rng);
	if (u_sample_count > 0u) {
		vec3 previous = imageLoad(screen, pixel_coords).rgb;
		average = mix(previous, average, 1.0 / float(u_sample_count + 1u));
	}
	imageStore(screen, pixel_coords, vec4(average, 1.0));
}
