// fractal_de171 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de171.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., e;
    for(int j=0;j++<8;)
      s*=e=2./clamp(dot(p,p),.2,1.),
      p=abs(p)*e-vec3(.5,8,.5);
    return length(cross(p,vec3(1,1,-1)))/s;
  }
