// fractal_de163 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de163.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p=sin(2.8*p+5.*sin(p*.3));
    float s=2., e;
    for(int i=0;i++<6;)
      p=abs(p-1.7)-1.5,
      s*=e=2.3/clamp(dot(p,p),.3,1.2),
      p=abs(p)*e;
    return length(p.zy)/s;
  }
