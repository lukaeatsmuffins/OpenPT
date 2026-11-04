// fractal_de127 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de127.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,s=3.,l;
    vec3 q=p;
    for(int j=0;j++<9;)
      p=mod(p-1.,2.)-1.,
      l=1.2/pow(pow(dot(pow(abs(p),vec3(5)),vec3(1)),.2),1.6),
      p*=l, s*=l;
    return abs(p.y)/s;
  }
