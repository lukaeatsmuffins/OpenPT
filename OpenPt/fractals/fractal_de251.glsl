// fractal_de251 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de251.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    vec3 Q;
    float d=1.,a;
    Q=mod(p,8.)-4.;
    Q.y+=1.5;
    d=a=2.;
    for(int j=0;j++<15;)
      Q.x=abs(Q.x),
      d=min(d,length(max(abs(Q)-.5,0.))/a),
      Q.xy=(Q.xy-vec2(.5,1))*rotate2D(-.785),
      Q*=1.41,
      a*=1.41;
    return d;
  }
