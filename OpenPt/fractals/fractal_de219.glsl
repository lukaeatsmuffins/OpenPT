// fractal_de219 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de219.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    p.y+=1.4;
    //p.xz*=rotate2D(t*.5+.5);
    for(int j=0;++j<9;)
      p=abs(p),
      p.xy*=rotate2D(-9.78),
      p.x<p.y?p=p.yxz:p,
      p.x<p.z?p=p.zyx:p,
      p.y<p.z?p=p.xzy:p,
      p.yz*=rotate2D(-1.16),
      p=1.9*p-vec3(1,1,-1);
    return length(p-clamp(p,-5.,5.))/500.;
  }
