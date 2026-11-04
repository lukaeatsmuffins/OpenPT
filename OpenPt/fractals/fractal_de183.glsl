// fractal_de183 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de183.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=1., e, offset=0.26; // vary between 0 and 1
    for(int i=0;i++<5;){
      s*=e=2./min(dot(p,p),1.);
      p=abs(p)*e-vec3(1,10.*offset,1);
    }
    return length(max(abs(p)-1.,0.))/s;
  }
