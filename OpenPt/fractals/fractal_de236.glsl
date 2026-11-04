// fractal_de236 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de236.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,j,d=1.,a;
    vec3 Q;
    a=1.;
    d=p.y+1.;
    for(j=0.;j++<9.;)
      Q=(p+fract(sin(j)*1e4)*3.141592)*a,
      Q+=sin(Q)*2.,
      d+=sin(Q.x)*sin(Q.z)/a,
      a*=2.;
    return d*.15;
  }
