// fractal_de168 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de168.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define M(p)p=vec2(sin(atan(p.x,p.y)*4.)/3.,1)*length(p),p.y-=2.
    float i,g,e,s;
    for(s=3.;s<4e4;s*=3.)
      M(p.xy),
      M(p.zy),
      p*=3.;
    return length(p.xy)/s-.001;
  }
