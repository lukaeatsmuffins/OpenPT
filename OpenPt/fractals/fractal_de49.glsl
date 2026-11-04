// fractal_de49 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de49.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define lpNorm fractal_de49_lpNorm

float lpNorm(vec3 p, float n){
    p = pow(abs(p), vec3(n));
    return pow(p.x+p.y+p.z, 1.0/n);
  }

  float de(vec3 p){
    float s = 1.;
    for(int i = 0; i < 9; i++) {
      p=p-2.*round(p/2.);
      float r2=1.1/max(pow(lpNorm(p.xyz, 4.5),1.6),.15);
      p*=r2; s*=r2;
    }
    return length(p)/s-.001;
  }
