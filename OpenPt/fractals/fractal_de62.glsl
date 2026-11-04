// fractal_de62 - by mrange
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de62.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sphere_fold fractal_de62_sphere_fold
#define pmin fractal_de62_pmin
#define box_fold fractal_de62_box_fold
#define sphere fractal_de62_sphere
#define torus fractal_de62_torus

void sphere_fold(inout vec3 z, inout float dz) {
  const float fixed_radius2 = 1.9;
  const float min_radius2   = 0.5;
    float r2 = dot(z, z);
    if(r2 < min_radius2) {
      float temp = (fixed_radius2 / min_radius2);
      z *= temp;
      dz *= temp;
    } else if(r2 < fixed_radius2) {
      float temp = (fixed_radius2 / r2);
      z *= temp;
      dz *= temp;
    }
  }
  vec3 pmin(vec3 a, vec3 b, vec3 k) {
    vec3 h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0);
    return mix(b, a, h) - k*h*(1.0-h);
  }
  void box_fold(float k, inout vec3 z, inout float dz) {
    // soft clamp after suggestion from ollij
    const vec3  folding_limit = vec3(1.0);
    vec3 zz = sign(z)*pmin(abs(z), folding_limit, vec3(k));
    z = zz * 2.0 - z;
  }
  float sphere(vec3 p, float t) {
    return length(p)-t;
  }
  float torus(vec3 p, vec2 t) {
    vec2 q = vec2(length(p.xz)-t.x,p.y);
    return length(q)-t.y;
  }
  float de(vec3 z) {
    const float scale = -2.8;
    vec3 offset = z;
    float dr = 1.0;
    float fd = 0.0;
    const float k = 0.05;
    for(int n = 0; n < 5; ++n) {
      box_fold(k/dr, z, dr);
      sphere_fold(z, dr);
      z = scale * z + offset;
      dr = dr * abs(scale) + 1.0;
      float r1 = sphere(z, 5.0);
      float r2 = torus(z, vec2(8.0, 1));
      float r = n < 4 ? r2 : r1;
      float dd = r / abs(dr);
      if (n < 3 || dd < fd) {
        fd = dd;
      }
    }
    return fd;
  }
