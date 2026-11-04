// fractal_de151 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de151.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g=.3,e,s=2.,q;
    for(int i=0;i++<7;p=vec3(2,5,1)-abs(abs(abs(p)*e-3.)-vec3(2,5,1)))
      s*=e=12./min(dot(p,p),12.);
    return min(1.,length(p.xz)-.2)/s;
  }
