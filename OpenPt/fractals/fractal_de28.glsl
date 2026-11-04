// fractal_de28 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de28.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s=1.;
    for(int i=0;i<3;i++){
      p=abs(p)-.3;
      if(p.x < p.y)p.xy=p.yx;
      if(p.x < p.z)p.xz=p.zx;
      if(p.y < p.z)p.yz=p.zy;
      p.xy-=.2; p*=2.; s*=2.;
    }
    p/=s;
    float h=.5;
    p.x-=clamp(p.x,-h,h);
    return length(vec2(length(p.xy)-.5,p.z))-.05;
  }
