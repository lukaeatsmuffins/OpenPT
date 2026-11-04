// fractal_de230 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de230.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    vec3 Q = abs(mod(p,1.8)-.9);
    float a=3.;
    float d = 1.;
    for(int j=0;j++<9;)
      Q=2.*clamp(Q,-.9,.9)-Q,
      d=dot(Q,Q),
      Q/=d,a/=d;
    if(Q.z>Q.x)
      Q.xz=Q.zx;
    if(Q.z>Q.y)
      Q.yz=Q.zy;
    Q.yx*=rotate2D(3.1415/4.);
    return (length(Q.zx)-.03)/a;
  }
