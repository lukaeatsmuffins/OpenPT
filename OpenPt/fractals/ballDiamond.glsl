// ballDiamond - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/ballDiamond.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
  float e, s=6., u=0.0;
  for(int j=0;j++<7;p=mod(p+1.,2.)-1.)
    s/=u=dot(p,p),
    p/=u;
  return e=dot(p,p)/s-abs(p.y)/s;
}
