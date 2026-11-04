// fractal_de56 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de56.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 q;
    p-=vec3(1.,.1,.1);
    q=p;
    float s=1.5;
    float e=0.;
    for(int j=0;j++<15;s*=e)
      p=sign(p)*(1.2-abs(p-1.2)),
      p=p*(e=8./clamp(dot(p,p),.3,5.5))+q*2.;
    return length(p)/s;
  }
