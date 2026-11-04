// fractal_de20 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de20.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s=3.;
    for(int i = 0; i < 4; i++) {
      p=mod(p-1.,2.)-1.;
      float r=1.2/dot(p,p);
      p*=r; s*=r;
    }
    p = abs(p)-0.8;
    if (p.x < p.z) p.xz = p.zx;
    if (p.y < p.z) p.yz = p.zy;
    if (p.x < p.y) p.xy = p.yx;
    return length(cross(p,normalize(vec3(0,1,1))))/s-.001;
  }
