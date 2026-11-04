// fractal_de65 - by mrange
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de65.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define mod3 fractal_de65_mod3
#define sphere_fold fractal_de65_sphere_fold
#define box_fold fractal_de65_box_fold
#define sphere fractal_de65_sphere
#define torus fractal_de65_torus
#define mb fractal_de65_mb

vec3 mod3(inout vec3 p, vec3 size) {
    vec3 c = floor((p + size*0.5)/size);
    p = mod(p + size*0.5, size) - size*0.5;
    return c;
  }
  void sphere_fold(float fr, inout vec3 z, inout float dz) {
  const float fixed_radius2 = 4.5;
  const float min_radius2   = 0.5;
    float r2 = dot(z, z);
    if(r2 < min_radius2) {
      float temp = (fr / min_radius2);
      z *= temp;
      dz *= temp;
    } else if(r2 < fr) {
      float temp = (fr / r2);
      z *= temp;
      dz *= temp;
    }
  }
  void box_fold(float fl, inout vec3 z, inout float dz) {
    z = clamp(z, -fl, fl) * 2.0 - z;
  }
  float sphere(vec3 p, float t) {
    return length(p)-t;
  }
  float torus(vec3 p, vec2 t) {
    vec2 q = vec2(length(p.xz)-t.x,p.y);
    return length(q)-t.y;
  }
  float mb(float fl, float fr, vec3 z) {
    vec3 offset = z;
    const float scale = -3.0;
    float dr = 1.0;
    float fd = 0.0;
    for(int n = 0; n < 5; ++n) {
      box_fold65(fl, z, dr);
      sphere_fold65(fr, z, dr);
      z = scale * z + offset;
      dr = dr * abs(scale) + 1.0;
      float r1 = sphere65(z, 5.0);
      float r2 = torus65(z, vec2(8.0, 1));
      float r = n < 4 ? r2 : r1;
      float dd = r / abs(dr);
      if (n < 3 || dd < fd) {
        fd = dd;
      }
    }
    return fd;
  }
  #define PATHA 0.4*vec2(0.11, 0.21)
  #define PATHB 0.7*vec2(13.0, 3.0)
  float de(vec3 p) {
    float tm = p.z;
    const float folding_limit = 2.3;
    const vec3  rep = vec3(10.0);

    vec3 wrap = vec3(sin(tm*PATHA)*PATHB, tm);
    vec3 wrapDeriv = normalize(vec3(PATHA*PATHB*cos(PATHA*tm), 1.0));
    p.xy -= wrap.xy;
    p -= wrapDeriv*dot(vec3(p.xy, 0), wrapDeriv)*0.5*vec3(1,1,-1);

    p -= rep*vec3(0.5, 0.0, 0.0);
    p.y *= (1.0 + 0.1*abs(p.y));
    vec3 i = mod3(p, rep);

    const float fixed_radius2 = 4.5;
    float fl = folding_limit + 0.3*sin(0.025*p.z+1.0)- 0.3;
    float fr = fixed_radius2 - 3.0*cos(0.025*sqrt(0.5)*p.z-1.0);

    return mb(fl, fr, p);
  }
