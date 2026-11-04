// fractal_de117 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de117.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s = 1.;
    for(int j=0;j<7;j++)
      p=mod(p-1.,2.)-1.,
      p*=1.2, s*=1.2,
      p=abs(abs(p)-1.)-1.;
    return (length(cross(p,normalize(vec3(2,2.03,1))))/s)-0.02;
  }
