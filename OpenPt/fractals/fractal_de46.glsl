// fractal_de46 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de46.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s = 2.;
    float e = 0.;
    for(int j=0;++j<7;)
      p.xz=abs(p.xz)-2.3,
      p.z>p.x?p=p.zyx:p,
      p.z=1.5-abs(p.z-1.3+sin(p.z)*.2),
      p.y>p.x?p=p.yxz:p,
      p.x=3.-abs(p.x-5.+sin(p.x*3.)*.2),
      p.y>p.x?p=p.yxz:p,
      p.y=.9-abs(p.y-.4),
      e=12.*clamp(.3/min(dot(p,p),1.),.0,1.)+
      2.*clamp(.1/min(dot(p,p),1.),.0,1.),
      p=e*p-vec3(7,1,1),
      s*=e;
    return length(p)/s;
  }
