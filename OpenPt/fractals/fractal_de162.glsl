// fractal_de162 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de162.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., offset=8., e;
    for(int i=0;i++<9;p=vec3(2,4,2)-abs(abs(p)*e-vec3(4,4,2)))
      s*=e=max(1.,(8.+offset)/dot(p,p));
    return min(length(p.xz),p.y)/s;
  }
