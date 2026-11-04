// fractal_de181 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de181.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=4., e;
    for(int i=0;i++<7;p.y-=10.)
      p.xz=.8-abs(p.xz),
      p.x < p.z?p=p.zyx:p,
      s*=e=2.5/clamp(dot(p,p),.1,1.2),
      p=abs(p)*e-1.;
    return length(p)/s+.001;
  }
