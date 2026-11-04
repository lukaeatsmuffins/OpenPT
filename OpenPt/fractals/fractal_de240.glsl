// fractal_de240 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de240.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    float i,j,d=1.,a;
    d=.6; a=1.;
    for(j=0.;j++<9.;)
      Q=(p+fract(sin(j*vec3(7,8,9))*1e3)*9.)*a,
      Q+=sin(Q*.5),
      Q=sin(Q),
      d+=Q.x*Q.y*Q.z/a,
      a*=2.;
    return d*.3;
  }
