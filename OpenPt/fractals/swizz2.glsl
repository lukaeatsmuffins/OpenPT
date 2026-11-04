// swizz2 - by illus0r
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/swizz2.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
float de(vec3 p){
  float t = time;
  float s = 1.;
  p.z += t * .1;
  p+=.5;
  float c = length(mod(p, 1.)-.5)-.7;
  for(int i = 0; i < 12; i++) {
    p.xy*=rot(time * .01);
    p*=1.3;
    s*=1.3;
    c = max(c, -(length(mod(p, 1.)-.5)-.4)/s);
  }
  return c;
}
