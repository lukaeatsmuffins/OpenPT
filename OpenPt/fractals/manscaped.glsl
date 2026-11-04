// manscaped - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/manscaped.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de ( vec3 p ) {
  float e,s;
  p.y-=p.z*.6;
  e=p.y-tanh(abs(p.x+sin(p.z)*.5));
  for(s=2.;s<1e3;s+=s)
    p.xz*=rotate2D(s),
    e+=abs(dot(sin(p.xz*s),vec2(1.0)/s/4.));
  e=min(e,p.y)-1.3;
  return e;
}
