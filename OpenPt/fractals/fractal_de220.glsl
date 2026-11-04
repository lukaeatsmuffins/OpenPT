// fractal_de220 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de220.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2.;
    float e = 0;
    float l=dot(p,p);
    p=abs(abs(p)-.4)-.2;
    p.x<p.y?p=p.yxz:p;
    p.y<p.z?p=p.xzy:p;
    for(int i=0;i++<8;){
      s*=e=2./min(dot(p,p),1.3);
      p=abs(p)*e-vec2(l,16.).xxy;
    }
    return length(p)/s;
  }
