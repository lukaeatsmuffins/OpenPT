// gripple - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gripple.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D, time

float de ( vec3 p ) {
  float t = 1.0; // time based adjustment
  p.xz+=vec2(cos(p.z*5.+t*2.),sin(p.x*8.));
  p.xz*=rotate2D(.5-atan(p.x,p.z));
  return .1*(p.z-p.y*p.y-.3);
}
