// 3D Burning Ship, Julia version: z starts at the point, c is a fixed constant.
// Same step as burning_ship.glsl:
//   theta  = atan2(length(z.xz), z.y) * power
//   zangle = atan2(z.x, z.z) * power
//   z      = abs(vec3(sin(zangle) sin(theta), cos(theta), sin(theta) cos(zangle)) * |z|^power + c)
// plus a running derivative for the distance estimate.
// Uses only settings.bulb_power; try power 2. Change BJ_C to reshape the whole fractal.

const vec3  BJ_C          = vec3(-0.5, 0.3, 0.2);
const int   BJ_ITERATIONS = 12;
const float BJ_BAILOUT    = 4.0;

float de(vec3 pos) {
	float n = settings.bulb_power;

	vec3 z = pos;
	float dr = 1.0;          // Julia: no "+ 1" below, c doesn't depend on the point
	float r = length(z);
	g_trap = r;

	for (int i = 0; i < BJ_ITERATIONS; ++i) {
		r = length(z);
		if (r > BJ_BAILOUT) {
			break;
		}
		g_trap = min(g_trap, r);

		dr = n * pow(r, n - 1.0) * dr;

		float theta  = atan(length(z.xz), z.y) * n;
		float zangle = atan(z.x, z.z) * n;
		float rn     = pow(r, n);

		z = abs(vec3(sin(zangle) * sin(theta),
		             cos(theta),
		             sin(theta) * cos(zangle)) * rn + BJ_C);
	}

	return 0.5 * log(r) * r / dr;
}
