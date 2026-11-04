// fractal_de57 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de57.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p.xz=fract(p.xz)-.5;
    float k=1.;
    float s=0.;
    for(int i=0;i++<9;)
      s=2./clamp(dot(p,p),.1,1.),
      p=abs(p)*s-vec3(.5,3,.5),
      k*=s;
    return length(p)/k-.001;
  }
