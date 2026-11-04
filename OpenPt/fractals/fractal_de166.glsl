// fractal_de166 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de166.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., e, offset = 1.; //offset can be adjusted
    for(int i=0;i++<8;p*=e)
      p=abs(p-vec3(1,3,1.5+offset*.3))-vec3(1,3.+offset*.3,2),
      p*=-1., s*=e=7./clamp(dot(p,p),.7,7.);
    return (p.z)/s+1e-3;
  }
