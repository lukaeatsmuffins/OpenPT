// fractal_de159 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de159.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    float s=2., e;
    for(int i=0;i++<8;){
      p=.5-abs(p);
      p.x < p.z?p=p.zyx:p;
      p.z < p.y?p=p.xzy:p;
      s*=e=1.6;
      p=abs(p)*e-vec3(.5,30,5);
      p.yz*=rotate2D(.3);
    }
    return length(p.xy)/s-.005;
  }
