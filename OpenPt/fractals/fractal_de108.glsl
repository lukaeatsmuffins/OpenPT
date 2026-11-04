// fractal_de108 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de108.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    vec3 q;
    float s=1., a=1., n=.5;
    for(int j=0;j++<9;){
      p.xy*=rotate2D(float(j*j));
      a*=.5; q=sin(p+=p);
      n+=q.x*q.y*q.z*a;
    }
    return n*.2;
  }
