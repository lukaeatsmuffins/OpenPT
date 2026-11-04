// fractal_de248 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de248.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    float i,d=1.,a;
    Q=abs(mod(p,1.8)-.9);
    a=3.;
    for(int j=0;j++<8;)
      Q=2.*clamp(Q,-.9,.9)-Q,
      d=dot(Q,Q),
      Q/=d,
      a/=d,
      Q+=.05;
    return d=(Q.x+Q.y+Q.z-1.6)/a;
  }
