// fractal_de160 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de160.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3.,e;
    for(int i=0;i++<3;p=vec3(2,4,2)-abs(abs(p)*e-vec3(3,6,1)))
      s*=e=1./min(dot(p,p),.6);
    return min(length(p.xz),abs(p.y))/s+.001;
  }
