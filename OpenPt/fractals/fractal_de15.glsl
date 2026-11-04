// fractal_de15 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de15.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    p=abs(p)-1.2;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=1.;
    for(int i=0;i<6;i++){
      p=abs(p);
      float r=2./clamp(dot(p,p),.1,1.);
      s*=r; p*=r; p-=vec3(.6,.6,3.5);
    }
    float a=1.5;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
