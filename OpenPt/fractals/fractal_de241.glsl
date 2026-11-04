// fractal_de241 - by adapted from code by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de241.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q,S;
    float d=1., a;
    Q=S=mod(p,10.)-5.;
    a=1.;
    for(int j=0;j++<9;) // max(_, 0.001) added to deal with divide by zero
      Q=2.*clamp(Q,-1.,1.)-Q,
      d=max(3./max(dot(Q,Q),0.001),1.),
      Q=2.*Q*d+S,
      a=2.*a*d+1.;
    return d=(length(Q)-9.)/max(a,0.001);
  }
