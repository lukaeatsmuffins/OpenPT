// fractal_de237 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de237.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q,S;
    float i,d=1.,a;
    Q=S=mod(p,8.)-4.;
    a=1.;
    for(int j=0;j++<9;a=a/d+1.)
      Q=2.*clamp(Q,-.7,.7)-Q,
      d=clamp(dot(Q,Q),.5,1.)*.5,
      Q=Q/d+S;
    return max((length(Q)-6.)/a,dot(sin(p),cos(p.yzx))+1.2)*0.6;
  }
