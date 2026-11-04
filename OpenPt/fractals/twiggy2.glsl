// twiggy2 - by tk87
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/twiggy2.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate3D

float de ( vec3 p ) {
  float d = 0;
  p.z+=.8;
  for(int i=0;++i<10;)
    p.y-=clamp(p.y,.0,.1),
    p=abs(p),
    p*=rotate3D(.4,vec3(1,.2,-1)),
    p*=1.1;
  d=length(p)-.02;
  d*=.39;
  return d;
}
