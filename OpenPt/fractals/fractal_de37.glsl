// fractal_de37 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de37.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ) {
    float s=2.,r2;
    p=abs(p);
    for(int i=0; i<12;i++) {
      p=1.-abs(p-1.);
      r2=1.2/dot(p,p);
      p*=r2; s*=r2;
    }
    return length(cross(p,normalize(vec3(1))))/s-0.003;
  }
