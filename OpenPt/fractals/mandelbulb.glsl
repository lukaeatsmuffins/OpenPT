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

float de(vec3 p) {
	float trap;
	float d = sdMandelbulb(p.xzy, trap);
	g_trap = trap;
	return d;
}

