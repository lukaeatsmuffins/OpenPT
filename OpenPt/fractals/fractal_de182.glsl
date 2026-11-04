// fractal_de182 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de182.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., e;
    for(int i=0;i++<10;){
      p=.3-abs(p-.8);
      p.x < p.z?p=p.zyx:p;
      p.z < p.y?p=p.xzy:p;
      s*=e=1.7;
      p=abs(p)*e-vec3(1,50,5);
    }
    return length(p.xy)/s+.001;
  }
