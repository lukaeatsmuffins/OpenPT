// fractal_de118 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de118.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., l=0.;
    p=abs(p);
    for(int j=0;j++<8;)
      p=1.-abs(abs(p-2.)-1.),
      p*=l=1.2/dot(p,p), s*=l;
    return dot(p,normalize(vec3(3,-2,-1)))/s;
  }
