// fractal_de261 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de261.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p.xz=abs(.5-mod(p.xz,1.))+.01;
    float DEfactor=1.;
    escape = 0.;
    for (int i=0; i<14; i++) {
      p = abs(p)-vec3(0.,2.,0.);  
      float r2 = dot(p, p);
      float sc=2./clamp(r2,0.4,1.);
      p*=sc; 
      DEfactor*=sc;
      p = p - vec3(0.1,1.2,0.5);
      escape += exp(-0.2*dot(p,p));
    }
    return length(p)/DEfactor-.0005;
  }
