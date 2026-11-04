// chorse - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/chorse.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

float de ( vec3 p ) {
  float e=0.7;
  float s=5.0;
  float u;
  float t = 65.0; // time varying adjustment term
  for(int j=0;j++<12;p.xz=mod(p.xz-1.,2.)-1.)
    s/=u=dot(p,p),
    p/=-u,
    p.x=sin(t)*.25-p.x,
    p.z=cos(t)*.25-p.z,
    p.y+=1.75,
    e=min(e,p.y/s);
  return e;
}
