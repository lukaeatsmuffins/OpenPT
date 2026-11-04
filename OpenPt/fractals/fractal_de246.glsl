// fractal_de246 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de246.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

#define D dot(sin(Q),cos(Q.yzx))+1.35
  float de(vec3 p){
    vec3 Q;
    float d = 0.;
    Q=p,  d=D,  Q.x+=M_PI;
    d=min(d,D), Q.y+=M_PI;
    d=max(abs(min(d,D)+snoise3D(Q*2.)*.05),.01);
    return d*.5;
  }
