// fractal_de18 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de18.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define lpNorm fractal_de18_lpNorm

float lpNorm( vec3 p, float n ){
    p = pow(abs(p), vec3(n));
    return pow(p.x+p.y+p.z, 1.0/n);
  }

  float de( vec3 p ){
    vec3 offset=p*.5;
    float s=2.;
    for (int i=0; i<5; i++){
      p=clamp(p,-1.,1.)*2.-p;
      float r=-10.*clamp(max(.3/pow(
      lpNorm(p,5.),2.),.3),.0,.6);
      s*=r; p*=r; p+=offset;
    }
    s=abs(s); float a=10.;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
