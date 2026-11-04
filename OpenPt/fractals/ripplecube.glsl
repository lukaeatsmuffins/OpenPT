// ripplecube - by leon
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/ripplecube.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot ripplecube_rot
#define gyroid ripplecube_gyroid
#define fbm ripplecube_fbm

mat2 rot (float a) { float c=cos(a),s=sin(a); return mat2(c,-s,s,c); }
float gyroid (vec3 p) { return dot(cos(p),sin(p.yzx)); }
float fbm( vec3 p ) {
  float result = 0.;
  float a = .5;
  for (float i = 0.; i < 3.; ++i)
  {
    p += result;
    p.z += time*.2;
    result += abs(gyroid(p/a)*a);
    a /= 2.;
  }
  return result;
}

float de( vec3 p ) {
  float dist = 100.0f;
  p.xz *= rot(time * .2);
  p.xy *= rot(time * .1);
  vec3 q = p;
  
  p = abs(p)-1.3;
  dist = max(p.x, max(p.y, p.z));
  dist -= fbm(q)*.2;
  dist = abs(dist)-.03;
  
  return dist * .5;
}
