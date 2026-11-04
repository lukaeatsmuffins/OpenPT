// dark - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/dark.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D, PI

float de ( vec3 p ) {
  // added some clamping to prevent potential div by 0
  float y,s,e;
  p+=vec3(1.0);
  y=p.y*.3-.3;
  s=9.;
  for(int j=0;j++<9;p/=max(e,0.0001))
    p=mod(p-1.,2.)-1.,
    p.zx*=rotate2D(PI/4.0),
    e = dot(p,p)*(0.6+y),
    s /= max(e,0.0001);
  return e=sqrt(e)/s;
}
