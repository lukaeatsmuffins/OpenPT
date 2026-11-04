// fractal_de239 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de239.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    float i,j,d=1.,a;
    d=min(p.y,0.)+.3;
    a=1.;
    for(j=0.;j++<9.;)
      Q=(p+vec3(9,0,0)+fract(sin(j)*1e3)*6.283)*a,
      Q+=sin(Q)*2.,
      Q=sin(Q),
      d+=Q.x*Q.y*Q.z/a,
      a*=2.;
    return d*.3;
  }
