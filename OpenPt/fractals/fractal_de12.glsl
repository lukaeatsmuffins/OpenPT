// fractal_de12 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de12.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define fold fractal_de12_fold

vec3 fold( vec3 p0 ){
    vec3 p = p0;
    if(length(p) > 1.2) return p;
    p = mod(p,2.)-1.;
    return p;
  }

  float de( vec3 p0 ){
    vec4 p = vec4(p0, 1.);
    for(int i = 0; i < 12; i++){
      if(p.x > p.z)p.xz = p.zx;
      if(p.z > p.y)p.zy = p.yz;
      p = abs(p);
      p.xyz = fold(p.xyz);
      p.xyz = mod(p.xyz-1., 2.)-1.;
      p*=(1.2/dot(p.xyz,p.xyz));
    }
    p/=p.w;
    return abs(p.x)*0.25;
  }
