// fractal_de243 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de243.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D fractal_de243_rotate2D

mat2 rotate2D(float r){
    return mat2(cos(r), sin(r), -sin(r), cos(r));
  }
  float de(vec3 p){
    vec3 R=p,Q;
    float i,d=1.,a;
    Q=R;
    d=a=1.5;
    for(int j=0;j++<9;)
      Q.xz=abs(Q.xz)*rotate2D(.785),
      d=min(d,(Q.x+Q.y*.5)/1.12/a),
      Q*=2., Q.x-=3., Q.y+=1.5,
      Q.yx*=rotate2D(.3),
      a*=2.;
    return d;
  }
