// fractal_de92 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de92.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=3., l=0.;
    vec3 q=p;
    p=mod(p,4.)-2.;
    p=abs(p);
    for(int j=0;j++<8;)
      p=1.-abs(p-1.),
      p=p*(l=-1.*max(1./dot(p,p),1.))+.5,
      s*=l;
    return max(.2-length(q.xy),length(p)/s);
  }
