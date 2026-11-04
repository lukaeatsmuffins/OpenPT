// fractal_de250 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de250.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    vec3 Q;
    float d=1.,a;
    Q=p; d=a=1.;
    for(int j=0;j++<8;)
      d=min(d,(length(Q)-.5)/a),
      Q.xz*=rotate2D(ceil(atan(Q.z,Q.x)/1.05-.5)*1.05),
      Q.x-=1., a*=3., Q*=3.;
    return d;
  }
