// fractal_de247 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de247.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q,S;
    Q=S=p;
    float a=1.,d;
    for(int j=0;j++<9;a=a/d+1.)
      Q=2.*clamp(Q,-.6,.6)-Q,
      d=clamp(dot(Q,Q),.1,1.)*.5,
      Q=Q/d+S;
    return d=(length(Q)-9.)/a;
  }
