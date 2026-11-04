// fractal_de55 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de55.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2.;
    float e=0.;
    vec3 q=vec3(3,3,.0);
    for(int i=0; i++<7; p=q-abs(p-q*.4))
      s*=e=15./min(dot(p,p),15.),
      p=abs(p)*e-2.;
    return (length(p.xz)-.5)/s;
  }
