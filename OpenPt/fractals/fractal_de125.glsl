// fractal_de125 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de125.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,R=2.,S;
    for(int j=0;j++<9;)
      p=1.-abs(p-1.),
      p*=S=(j%3>1)?1.3:1.2/dot(p,p),
      R*=S;
    return length(cross(p,vec3(.5)))/R-5e-3;
  }
