// fractal_de257 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de257.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p=fract(p)-.5;
    float s=3., l;
    for(int j=0;j++<8;)
      p=abs(p),
      p=p.x<p.y?p.zxy:p.zyx,
      s*=l=2./min(dot(p,p),1.),
      p=p*l-vec3(.2,1,4);
    return length(p)/s;
  }
