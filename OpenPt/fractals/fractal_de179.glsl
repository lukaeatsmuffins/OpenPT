// fractal_de179 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de179.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float n=1.+snoise3D(p), s=4., e;
    for(int i=0;i++<7;p.y-=20.*n)
      p.xz=.8-abs(p.xz),
      p.x < p.z?p=p.zyx:p,
      s*=e=2.1/min(dot(p,p),1.),
      p=abs(p)*e-n;
    return length(p)/s+1e-4;
  }
