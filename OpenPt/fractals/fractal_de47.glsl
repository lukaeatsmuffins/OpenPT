// fractal_de47 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de47.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s = 4.;
    for(int i = 0; i < 8; i++) {
      p=mod(p-1.,2.)-1.;
      float r2=(i%3==0)?1.5:1.2/dot(p,p);
      p*=r2; s*=r2;
    }
    vec3 q=p/s;
    q.xz=mod(q.xz-.002,.004)-.002;
    return min(length(q.yx)-.0003,length(q.yz)-.0003);
  }
