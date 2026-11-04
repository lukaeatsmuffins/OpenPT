// fractal_de128 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de128.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,s=4.,l;
    vec3 q=p;
    for(int j=0;j++<9;)
      p=mod(p-1.,2.)-1.,
      l=1.2/dot(p,p),
      p*=l, s*=l;
    return abs(p.y)/s;
  }
