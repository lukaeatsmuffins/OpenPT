// fractal_de180 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de180.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., e;
    for(int i=0;i++<8;)
      p=mod(p-1.,2.)-1.,
      s*=e=1.4/dot(p,p),
      p*=e;
    return length(p.yz)/s;
  }
