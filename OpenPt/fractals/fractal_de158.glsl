// fractal_de158 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de158.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    float s=2., e;
    for(int j=0;j++<8;){
      p=.1-abs(p-.2);
      p.x < p.z?p=p.zyx:p;
      s*=e=1.6;
      p=abs(p)*e-vec3(.1,3,1);
      p.yz*=rotate2D(.8);
    }
    return length(p.yx)/s-.04;
  }
