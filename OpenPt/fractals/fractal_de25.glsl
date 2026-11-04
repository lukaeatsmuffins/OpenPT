// fractal_de25 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de25.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    p=abs(p);
    float s=3.;
    vec3  offset = p*.5;
    for (float i=0.; i<5.; i++){
      p=1.-abs(p-1.);
      float r=-3.*clamp(.57*max(3./dot(p,p),.9),0.,1.);
      s*=r; p*=r; p+=offset;
    }
    s=abs(s);
    return length(cross(p,normalize(vec3(1))))/s-.008;
  }
