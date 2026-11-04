// fractal_de227 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de227.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s = 1.;
    float t = 999.;
    for(int i = 0; i < 12; i++){
      float k =  1.3/clamp(dot(p,p),0.1,1.);
      p *= k; s *= k;
      p=abs(p)-vec3(6.2,2.,1.7);
      p=mod(p-1.,2.)-1.;
      t = min(t, length(p)/s);
    }
    return t;
  }
