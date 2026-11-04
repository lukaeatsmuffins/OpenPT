// swizz - by illus0r
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/swizz.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

float de(vec3 p){
  float s = 1.;
  p.z += time;
  float c = length(mod(p, 1.)-.5)-.4;
  for(int i = 0; i < 10; i++) {
    p*=1.2;
    s*=1.2;
    c = max(c, -(length(mod(p, 1.)-.5)-.4)/s);
  }
  return c;
}
