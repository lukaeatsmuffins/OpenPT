// fractal_de222 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de222.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., e;
    s*=e=3./min(dot(p,p),20.);
    p=abs(p)*e;
    escape = 0.;
    for(int i=0;i++<12;){
      p=vec3(1,4,2)-abs(p-vec3(2,4,2)),
      s*=e=8./min(dot(p,p),12.),
      p=abs(p)*e;
      escape += exp(-0.2*dot(p,p));
    }
    return min(length(p.xz)-.1,p.y)/s;
  }
