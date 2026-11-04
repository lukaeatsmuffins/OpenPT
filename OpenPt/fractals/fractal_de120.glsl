// fractal_de120 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de120.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p.z-=20;
    float s=3., l=0.;
    p=abs(p);
    for(int j=0;j++<10;)
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.),
      p*=l=-1./max(.19,dot(p,p)),
      p-=.24, s*=l;
    return (length(p)/s);
  }
