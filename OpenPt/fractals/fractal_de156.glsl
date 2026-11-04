// fractal_de156 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de156.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    p.yz*=rotate2D(-.3);
    float ss=3., s=1.;
    for(int j=0; j++<7;){
      p=abs(p); p.y-=.5;
      s = 1./clamp(dot(p,p),.0,1.);
      p*=s; ss*=s;
      p-=vec2(1,.1).xxy;
      p.xyz=p.zxy;
    }
    return length(p.xy)/ss-.01;
  }
