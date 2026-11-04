// fractal_de167 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de167.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p=sin(p+3.*sin(p*.5));
    float s=2., e;
    for(int i=0;i++<5;)
      p=abs(p-1.7)-1.3,
      s*=e=2./min(dot(p,p),1.5),
      p=abs(p)*e-1.;
    return length(p)/s;
  }
