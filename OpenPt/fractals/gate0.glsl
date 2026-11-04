// gate0 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gate0.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
  float e, s=3.;
  p=.7-abs(p);
  p.x<p.y?p=p.yxz:p;
  for(int i=0;i++<8;)
    p=abs(p)-.9,
    e=dot(p,p),
    s*=e=2./min(e,2.)+6./min(e,.9),
    p=abs(p)*e-vec3(2,7,3);
  return e=length(p.yz)/s;
}
