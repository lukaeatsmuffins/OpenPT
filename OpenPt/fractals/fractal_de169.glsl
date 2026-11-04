// fractal_de169 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de169.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p=1.-abs(abs(p+sin(p))-1.);
    p=p.x < p.y?p.zxy:p.zyx;
    float s=5., l;
    for(int j=0;j++<4;)
      s*=l=2./min(dot(p,p),1.5),
      p=abs(p)*l-vec3(2,1,3);
    return length(p.yz)/s;
  }
