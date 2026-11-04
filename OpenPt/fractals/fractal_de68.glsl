// fractal_de68 - by dr2
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de68.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

// Prefix this entry's own globals so they can't clash with the host shader.
#define Rot2D fractal_de68_Rot2D
#define PrBoxDf fractal_de68_PrBoxDf

vec2 Rot2D (vec2 q, float a)
  {
    vec2 cs;
    cs = sin (a + vec2 (0.5 * M_PI, 0.));
    return vec2 (dot (q, vec2 (cs.x, - cs.y)), dot (q.yx, cs));
  }
  float PrBoxDf (vec3 p, vec3 b)
  {
    vec3 d;
    d = abs (p) - b;
    return min (max (d.x, max (d.y, d.z)), 0.) + length (max (d, 0.));
  }
  float de(vec3 p)
  {
    vec3 b;
    float r, a;
    const float nIt = 5., sclFac = 2.4;
    b = (sclFac - 1.) * vec3 (1., 1.125, 0.625);
    r = length (p.xz);
    a = (r > 0.) ? atan (p.z, - p.x) / (2. * M_PI) : 0.;
    p.y = mod (p.y - 4. * a + 2., 4.) - 2.;
    p.x = mod (16. * a + 1., 2.) - 1.;
    p.z = r - 32. / (2. * M_PI);
    p.yz = Rot2D (p.yz, 2. * M_PI * a);
    for (float n = 0.; n < nIt; n ++) {
      p = abs (p);
      p.xy = (p.x > p.y) ? p.xy : p.yx;
      p.xz = (p.x > p.z) ? p.xz : p.zx;
      p.yz = (p.y > p.z) ? p.yz : p.zy;
      p = sclFac * p - b;
      p.z += b.z * step (p.z, -0.5 * b.z);
    }
    return 0.8 * PrBoxDf (p, vec3 (1.)) / pow (sclFac, nIt);
  }
