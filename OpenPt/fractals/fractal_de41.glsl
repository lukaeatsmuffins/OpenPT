// fractal_de41 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de41.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s=4.;
    p=abs(p);
    vec3 off=p*4.6;
    for (float i=0.; i<8.; i++){
      p=1.-abs(abs(p-2.)-1.);
      float r=-13.*clamp(.38*max(1.3/dot(p,p),.7),0.,3.3);
      s*=r; p*=r; p+=off;
    }
    return length(cross(p,normalize(vec3(1,3,3))))/s-.006;
  }
