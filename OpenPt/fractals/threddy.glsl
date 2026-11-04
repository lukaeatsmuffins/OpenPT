// threddy - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/threddy.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de ( vec3 p ) {
  float e = 1., g=0;
  for ( int i=0;i++<7;p=abs(p)-vec3(2,1,.2))
    p = 0.22-abs(abs(p)-.06),
    p = p.x>p.y?p.zxy:p.zyx,
    p *= 2.,
    e *= 2.,
    p.xz *= rotate2D(-.6);
    p /= e;
    g += e = length(p.xy);
  return e;
}
