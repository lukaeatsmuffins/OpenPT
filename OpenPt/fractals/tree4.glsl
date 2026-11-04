// tree4 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/tree4.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de( vec3 p ){
  vec3 q = vec3(-.1,.65,-.6);
  float j,i,e,v,u;
  for(j=e=v=7.;j++<21.;e=min(e,max(length(p.xz=abs(p.xz*rotate2D(j+sin(1./u)/v))-.53)-.02/u,p.y=1.8-p.y)/v))
    v/=u=dot(p,p),p/=u+.01;
  return e;
}
