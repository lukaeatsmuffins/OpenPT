// fractal_de161 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de161.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., e;
    s*=e=3./min(dot(p,p),50.);
    p=abs(p)*e;
    for(int i=0;i++<5;)
      p=vec3(2,4,2)-abs(p-vec3(4,4,2)),
      s*=e=8./min(dot(p,p),9.),
      p=abs(p)*e;
    return min(length(p.xz)-.1,p.y)/s;
  }
