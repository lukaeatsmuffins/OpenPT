// gates - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gates.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
  float y=p.y+=.2;
  p.z-=round(p.z);
  float e, s=3.;
  p=.7-abs(p);
  for(int i=0;i++<8;p.z+=5.)
    p=abs(p.x>p.y?p:p.yxz)-.8,
    s*=e=5./min(dot(p,p),.5),
    p=abs(p)*e-6.;
  return e=min(y,length(p.yz)/s);
}
