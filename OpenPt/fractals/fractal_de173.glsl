// fractal_de173 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de173.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p.xz=abs(p.xz)-1.;
    p.x>p.z?p=p.zyx:p;
    float s=2., e;
    for(int j=0;j++<7;)
      s*=e=2.2/clamp(dot(p,p),.3,1.2),
      p=abs(p)*e-vec3(1,8,.03);
    return length(p.yz)/s;
  }
