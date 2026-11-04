// fractal_de238 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de238.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    float i,j,d=1.,a;
    d=dot(sin(p),cos(p.yzx))+1.2;
    a=1.;
    for(j=0.;j++<9.;)
      Q=(p+fract(sin(j)*3e3)*9.)*a,
      Q+=sin(Q*1.05)*2.,
      Q=sin(Q),
      d+=Q.x*Q.y*Q.z/a*.4,
      a*=2.;
    return d*.4;
  }
