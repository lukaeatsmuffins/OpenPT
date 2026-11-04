// fractal_de165 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de165.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=5., e;
    p=p/dot(p,p)+1.;
    for(int i=0;i++<8;p*=e)
      p=1.-abs(p-1.),
      s*=e=1.6/min(dot(p,p),1.5);
    return length(cross(p,normalize(vec3(1))))/s-5e-4;
  }
