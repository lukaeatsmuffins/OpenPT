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

#define MAX_MARCHING_STEPS 500
#define EPSILON 0.001f

float sceneSDF(vec3 p);
vec3 estimateNormal(vec3 p);

void main()
{
	float start = 0.0;
	float end = 10.0;
	ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);
	ivec2 dims = imageSize(screen);

	float x = float(pixel_coords.x * 2 - dims.x) / dims.x; // transforms to [-1.0, 1.0]
	x *= float(dims.x) / float(dims.y); // aspect ratio correction
	float y = float(pixel_coords.y * 2 - dims.y) / dims.y; // transforms to [-1.0, 1.0]

	vec3 ray_o = camera.pos.xyz;

	float d = 1.0 / tan(radians(camera.vfov) / 2.0);

	vec3 local = vec3(x, y, -d);

	vec3 ray_d = normalize(mat3(camera.u.xyz, camera.v.xyz, camera.w.xyz) * local);

	float a = 0.5*(ray_d.y + 1.0);
	vec4 pixel = (1.0-a)*vec4(1.0, 1.0, 1.0, 1.0) + a*vec4(0.5, 0.7, 1.0, 1.0);

	float depth = start;
	for (int i = 0; i < MAX_MARCHING_STEPS; i++) {
			float dist = sceneSDF(ray_o + depth * ray_d);
			if (dist < EPSILON) {
					pixel = vec4(estimateNormal(ray_o + depth * ray_d), 1.0);
					pixel = 0.5 * (pixel + 1);
					break;
			}
			depth += dist;

			if (depth >= end) {
					break;
			}
	}

	imageStore(screen, pixel_coords, pixel);
}
	
float sceneSDF(vec3 p) {
    return min(length(p) - 0.5, length(p-vec3(0,-100.5,0))-100);
}

vec3 estimateNormal(vec3 p) {
    return normalize(vec3(
        sceneSDF(vec3(p.x + EPSILON, p.y, p.z)) - sceneSDF(vec3(p.x - EPSILON, p.y, p.z)),
        sceneSDF(vec3(p.x, p.y + EPSILON, p.z)) - sceneSDF(vec3(p.x, p.y - EPSILON, p.z)),
        sceneSDF(vec3(p.x, p.y, p.z  + EPSILON)) - sceneSDF(vec3(p.x, p.y, p.z - EPSILON))
    ));
}
