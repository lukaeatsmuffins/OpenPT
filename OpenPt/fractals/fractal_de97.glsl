// fractal_de97 - by adapted from gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de97.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 a=vec3(.5);
    p.z-=55.;
    float s=2., l=0.;
    for(int j=0;j++<8;)
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.),
      s*=l=-2.12/max(.2,dot(p,p)),
      p=p*l-.55;
    return dot(p,a)/s;
  }
