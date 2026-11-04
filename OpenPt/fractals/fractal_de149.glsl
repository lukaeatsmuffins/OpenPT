// fractal_de149 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de149.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,s,q;
    q=length(p)-1.;
    p.y++;
    s=3.;
    for(int i=0;i++<7;p=vec3(0,5,0)-abs(abs(p)*e-3.))
      s*=e=max(1.,14./dot(p,p));
    return max(q,min(1.,length(p.xz)-.3))/s;
  }
