// fractal_de177 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de177.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., e;
    for(int i=0;i++<7;){
      p.xz=.8-abs(p.xz);
      p.x < p.z?p=p.zyx:p;
      s*=e=2.1/min(dot(p,p),1.);
      p=abs(p)*e-vec3(1,18,9);
    }
    return length(p)/s-0.01;
  }
