// fractal_de72 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de72.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float g=1.;
    float e=0.;
    vec3 q=vec3(0);
    p.z-=1.;
    q=p;
    float s=2.;
    for(int j=0;j++<8;)
      p-=clamp(p,-.9,.9)*2.,
      p=p*(e=3./min(dot(p,p),1.))+q,
      s*=e;
    return length(p)/s;
  }
