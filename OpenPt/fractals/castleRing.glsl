// castleRing - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/castleRing.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

float de(vec3 p){
  float e, r, s=3., t = 0.0;
  p=vec3(log(r=length(p)),asin(p.z/r),atan(p.y,p.x)/PI*s)-t/PI;
  p-=round(p);
  for(int j=0;j++<7;p.z-=2.)
    s/=e=min(.3,dot(p,p))+.2,
    p=abs(p)/e-.2;
  return e=(length(p.xy)-.1)*r/s;
}
