// 3D Burning Ship (Mandelbrot type): z starts at 0, c is the point itself.
// Escape-time formula:
//   theta  = atan2(length(z.xz), z.y) * power      (angle from the y axis)
//   zangle = atan2(z.x, z.z) * power                (angle around the y axis)
//   z      = abs(vec3(sin(zangle) sin(theta), cos(theta), sin(theta) cos(zangle)) * |z|^power + c)
// plus a running derivative so it can be ray marched (distance estimate).
// Uses only settings.bulb_power; everything else is local to this file.

const int   BS_ITERATIONS = 12;
const float BS_BAILOUT    = 4.0;

float de(vec3 pos) {
	float n = settings.bulb_power;

	// The first iteration from z = 0 gives z = abs(c), so start there:
	// it avoids the angles of the zero vector, which are undefined.
	vec3 z = abs(pos);
	float dr = 1.0;          // derivative of z with respect to the point
	float r = length(z);
	g_trap = r;

	for (int i = 0; i < BS_ITERATIONS; ++i) {
		r = length(z);
		if (r > BS_BAILOUT) {
			break;
		}
		g_trap = min(g_trap, r);

		dr = n * pow(r, n - 1.0) * dr + 1.0;   // Mandelbrot type: "+ 1" because c is the point

		float theta  = atan(length(z.xz), z.y) * n;
		float zangle = atan(z.x, z.z) * n;
		float rn     = pow(r, n);

		z = abs(vec3(sin(zangle) * sin(theta),
		             cos(theta),
		             sin(theta) * cos(zangle)) * rn + pos);
	}

	return 0.5 * log(r) * r / dr;
}
