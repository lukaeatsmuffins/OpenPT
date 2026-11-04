// fractal_de150 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de150.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., e=0.;
    for(int i=0;i++<8;p=abs(p)*e)
      p=vec3(.8,2,1)-abs(p-vec3(1,2,1)),
      s*=e=1.3/clamp(dot(p,p),.1,1.2);
    return min(length(p.xz),p.y)/s+.001;
  }
