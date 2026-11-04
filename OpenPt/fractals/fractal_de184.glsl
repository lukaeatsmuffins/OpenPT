// fractal_de184 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de184.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2.5, e;
    p=abs(mod(p-1.,2.)-1.)-1.;
    for(int j=0;j++<10;)
      p=1.-abs(p-1.),
      s*=e=-1.8/dot(p,p),
      p=p*e-.7;
    return abs(p.z)/s+.001;
  }
