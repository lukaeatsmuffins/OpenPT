// fractal_de121 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de121.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s=2., l=0.;
    p=abs(mod(p-1.,2.)-1.);
    for(int j=0;j++<8;)
      p=1.-abs(abs(abs(p-5.)-2.)-2.),
      p*=l=-1.3/dot(p,p),
      p-=vec3(.3,.3,.4), s*=l;
    return length(p.yz)/s;
  }
