// fractal_de152 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de152.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    float i,d=1.,a,b=sqrt(3.);
    Q=mod(p,b*2.)-b;
    a=1.; d=9.;
    for(int j=0;j++<7;){
      Q=abs(Q);
      d=min(d,(dot(Q,vec3(1)/b)-1.)/a);
      Q=Q*3.-6./b;a*=3.;
    }
    return d;
  }
