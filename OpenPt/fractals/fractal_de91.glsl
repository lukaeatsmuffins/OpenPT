// fractal_de91 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de91.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=4.;
    float l=0;
    p.z-=.9;
    vec3 q=p;
    s=2.;
    for(int j=0;j++<9;)
      p-=clamp(p,-1.,1.)*2.,
      p=p*(l=8.8*clamp(.72/min(dot(p,p),2.),0.,1.))+q,
      s*=l;
    return length(p)/s;
  }
