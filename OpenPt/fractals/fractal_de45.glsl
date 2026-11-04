// fractal_de45 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de45.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    p.z-=2.5;
    float s = 3.;
    float e = 0.;
    for(int j=0;j++<8;)
      s*=e=3.8/clamp(dot(p,p),0.,2.),
      p=abs(p)*e-vec3(1,15,1);
    return length(cross(p,vec3(1,1,-1)*.577))/s;
  }
