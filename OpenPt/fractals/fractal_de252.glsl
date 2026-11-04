// fractal_de252 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de252.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

#define D d=min(d,length(vec2(length(Q.zx)-.3,Q.y))-.02)
  float de(vec3 p){
    vec3 Q;
    float i,d=1.;
    Q=abs(fract(p)-.5),
    Q=Q.x>Q.z?Q.zyx:Q,
    d=9.,    D,
    Q-=.5,   D,
    Q.x+=.5,
    Q=Q.xzy, D,
    Q.z+=.5,
    Q=Q.zxy, D;
    return d;
  }
