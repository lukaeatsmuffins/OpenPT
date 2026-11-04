// fractal_de231 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de231.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q=abs(mod(p,1.8)-.9);
    float a=1.;
    float d=1.;
    for(int j=0;j++<8;)
      Q=2.*clamp(Q,-.9,.9)-Q,
      d=dot(Q,Q),
      Q/=d,
      a/=d;
    return (Q.x+Q.y+Q.z-1.3)/a/3.;
  }
