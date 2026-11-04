// twiggy - by tk87
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/twiggy.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D twiggy_rotate2D

mat2 rotate2D ( float r ) {
  return mat2(cos(r), sin(r), -sin(r), cos(r));
}
float de ( vec3 p ) {
  float d = 0;
  p.z+=3.;
  for(int i=0;++i<10;)
    p.y-=clamp(p.y,.0,.3),
    p.xz-=.05,
    p=abs(p),
    p.yx*=rotate2D(.6),
    p.zx*=rotate2D(1.4),
    p*=1.1;
    d=length(p)-.05;
    d*=.39;
  return d;
}
