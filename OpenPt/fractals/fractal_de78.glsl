// fractal_de78 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de78.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2.;
    float l=dot(p,p);
    float e=0.;
    escape=0.;
    p=abs(abs(p)-.7)-.5;
    p.x < p.y?p=p.yxz:p;
    p.y < p.z?p=p.xzy:p;
    for(int i=0;i++<8;){
      s*=e=2./clamp(dot(p,p),.004+tan(12.)*.002,1.35);
      p=abs(p)*e-vec2(.5*l,12.).xxy;
    }
    return length(p-clamp(p,-1.,1.))/s;
  }
