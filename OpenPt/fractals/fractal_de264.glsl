// fractal_de264 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de264.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p=cos(p);
    float s=2., e;
    for(int j=0;j++<7;)
      p=1.8-abs(p-1.2),
      p=p.x<p.y?p.zxy:p.zyx,
      s*=e=4.5/min(dot(p,p),1.5),
      p=p*e-vec3(.2,3,4);
    return length(p.xz)/s;
  }
