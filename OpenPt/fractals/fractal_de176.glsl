// fractal_de176 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de176.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2.,e;
    for(int i=0;i<9;i++){
      p=.5-abs(p-.5);
      p.x < p.z?p=p.zyx:p;
      p.z < p.y?p=p.xzy:p;
      s*=e=2.4;
      p=abs(p)*e-vec3(.1,13,5);
    }
    return length(p)/s-0.01;
  }
