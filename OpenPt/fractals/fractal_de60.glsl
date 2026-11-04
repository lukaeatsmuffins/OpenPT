// fractal_de60 - by jorge2017a1
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de60.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define de2 fractal_de60_de2
#define de1 fractal_de60_de1

float de2(vec3 p) {
    vec3 op = p;
    p = abs(1.0 - mod(p, 2.));
    float r = 0., power = 8., dr = 1.;
    vec3 z = p;
    for (int i = 0; i < 7; i++) {
      op = -1.0 + 2.0 * fract(0.5 * op + 0.5);
      float r2 = dot(op, op);
      r = length(z);
      if (r > 1.616) break;
      float theta = acos(z.z / r);
      float phi = atan(z.y, z.x);
      dr = pow(r, power - 1.) * power * dr + 1.;
      float zr = pow(r, power);
      theta = theta * power;
      phi = phi * power;
      z = zr * vec3(sin(theta) * cos(phi), sin(phi) * sin(theta), cos(theta));
      z += p;
    }
    return (.5 * log(r) * r / dr);
  }

  float de1(vec3 p) {
    float s = 1.;
    float d = 0.;
    vec3 r,q;
    r = p;
    q = r;
    for (int j = 0; j < 6; j++) {
      r = abs(mod(q * s + 1.5, 2.) - 1.);
      r = max(r, r.yzx);
      d = max(d, (.3 - length(r *0.985) * .3) / s);
      s *= 2.1;
    }
    return d;
  }
  float de(vec3 p) {
    return min(de1(p), de2(p));
  }
