// fractal_de21 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de21.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s=3.; p=abs(p);
    for (float i=0.; i<9.; i++){
      p-=clamp(p,-1.,1.)*2.;
      float r=6.62*clamp(.12/min(dot(p,p),1.),0.,1.);
      s*=r; p*=r; p+=1.5;
    }
    s=abs(s); float a=.8;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
