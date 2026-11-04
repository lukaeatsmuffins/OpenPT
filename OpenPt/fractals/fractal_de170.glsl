// fractal_de170 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de170.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., e;
    for(int j=0;++j<5;)
      s*=e=1./min(dot(p,p),1.),
      p=abs(p)*e-1.5;
    return length(p.yz)/s;
  }
