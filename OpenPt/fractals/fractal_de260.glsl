// fractal_de260 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de260.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

float de(vec3 p){
    vec3 Q=p;
    float i,d=1.,c;
    Q.x+=M_PI/2.;
    c=dot(sin(Q),cos(Q.yzx))+1.;
    d=7.-length(p.xy);
    return d=(c+d-sqrt((c-d)*(c-d)+.2))*.5+snoise3D(p)*.1;
  }
