// fractal_de106 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de106.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    float i,a,n,h,d=1.,t=0.3; // change t for different behavior
    vec3 q;
    n=.4;
    for(a=1.;a<2e2;n+=q.x*q.y*q.z/a)
      p.xy*=rotate2D(a+=a),
      q=cos(p*a+t);
    return n*.3;
  }
