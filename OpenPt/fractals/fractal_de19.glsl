// fractal_de19 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de19.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

#define sabs1(p)sqrt((p)*(p)+1e-1)
  #define sabs2(p)sqrt((p)*(p)+1e-3)
  float de( vec3 p ){
    float s=2.; p=abs(p);
    for (int i=0; i<4; i++){
      p=1.-sabs2(p-1.);
      float r=-9.*clamp(max(.2/pow(min(min(sabs1(p.x),
        sabs1(p.y)),sabs1(p.z)),.5), .1), 0., .5);
      s*=r; p*=r; p+=1.;
    }
    s=abs(s); float a=2.;
    p-=clamp(p,-a,a);
    return length(p)/s-.01;
  }
