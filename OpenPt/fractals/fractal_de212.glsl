// fractal_de212 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de212.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float a=2.,s=3.,e,l=dot(p,p);
    p=abs(p)-1.;
    p.x < p.y?p=p.yxz:p;
    p.x < p.z?p=p.zyx:p;
    p.y < p.z?p=p.xzy:p;
    for(int i=0;i<8;i++){
      s*=e=2.1/clamp(dot(p,p),.1,1.);
      p=abs(p)*e-vec3(.3*l,1,5.*l);
    }
    p-=clamp(p,-a,a);
    return length(p)/s-0.;
  }
