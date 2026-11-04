// fractal_de259 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de259.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define deee fractal_de259_deee

#define X(V)d=min(d,length(V)-.13),
  float deee(vec3 p){
    vec3 R=p,Q;
    float d = 1.;
    Q=fract(R)-.5,
    X(Q.xy)
    X(Q.yz)
    X(Q.zx)
    d=max(d,.68-length(fract(R-.5)-.5));
    return d;
  }
