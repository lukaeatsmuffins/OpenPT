// spicy - by leon
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/spicy.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): noise, time

// Prefix this entry's own globals so they can't clash with the host shader.
#define gyroid spicy_gyroid
#define fbm spicy_fbm

float gyroid (vec3 seed) { return dot(sin(seed),cos(seed.yzx)); }
float fbm (vec3 seed) {
  float result = 0.;
  float a = .5;
  for (int i = 0; i < 5; ++i) {
    result += gyroid(seed/a+result/a)*a;
    a /= 2.;
  }
  return result;
}
float de(vec3 p){
  // spicy fbm cyclic gyroid noise
  float details = sin(time*.2-fbm(p)+length(p));
  return max(abs(details*.05), p.z+2.);
}
