// fractal_de59_2 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de59.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sphere fractal_de59_2_sphere
#define box fractal_de59_2_box
#define DE0 fractal_de59_2_DE0
#define DE2 fractal_de59_2_DE2

vec4 sphere (vec4 z) {
    float r2 = dot (z.xyz, z.xyz);
    if (r2 < 2.0)
      z *= (1.0 / r2);
    else z *= 0.5;
    return z;
  }
  vec3 box (vec3 z) {
    return clamp (z, -1.0, 1.0) * 2.0 - z;
  }
  float DE0 (vec3 pos) {
    vec3 from = vec3 (0.0);
    vec3 z = pos - from;
    float r = dot (pos - from, pos - from) * pow (length (z), 2.0);
    return (1.0 - smoothstep (0.0, 0.01, r)) * 0.01;
  }
  float DE2 (vec3 pos) {
    vec3 params = vec3 (0.5, 0.5, 0.5);
    vec4 scale = vec4 (-20.0 * 0.272321);
    vec4 p = vec4 (pos, 1.0), p0 = p;
    vec4 c = vec4 (params, 0.5) - 0.5; // param = 0..1

    for (float i = 0.0; i < 10.0; i++) {
      p.xyz = box(p.xyz);
      p = sphere(p);
      p = p * scale + c;
    }
    return length(p.xyz) / p.w;
  }
  float de (vec3 pos) {
    return max (DE0(pos), DE2(pos));
  }
