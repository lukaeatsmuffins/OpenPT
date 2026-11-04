// fractal_de107 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de107.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    vec3 z,q;
    p.z -= 9.; z=p;
    float a=1.,n=.9;
    for(int j=0;j++<15;){
      p.xy*=rotate2D(float(j*j));
      a*=.66;
      q=sin(p*=1.5);
      n+=q.x*q.y*q.z*a;
    }
    return (n*.2-z.z*.2);
  }
