// fractal_de221 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de221.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D fractal_de221_rotate2D

mat2 rotate2D(float r){
    return mat2(cos(r), sin(r), -sin(r), cos(r));
  }
  float de(vec3 p){
    float d, a;
    d=a=1.;
    for(int j=0;j++<9;)
      p.xz=abs(p.xz)*rotate2D(PI/4.),
      d=min(d,max(length(p.zx)-.3,p.y-.4)/a),
      p.yx*=rotate2D(.5),
      p.y-=3.,
      p*=1.8,
      a*=1.8;
    return d;
  }
