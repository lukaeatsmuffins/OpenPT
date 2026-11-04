// fractal_de187 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de187.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., e;
    for(int j=0;++j<18;s*=e=2./clamp(dot(p,p),.4,1.),p=abs(p)*e-vec3(2,1,.7));
    return length(p)/s;
  }
