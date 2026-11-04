// fractal_de146 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de146.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 q=p;
    float s=5., e=0.;
    for(int j=0;j++<8;s*=e)
      p=sign(p)*(1.-abs(abs(p-2.)-1.)),
      p=p*(e=6./clamp(dot(p,p),.1,3.))-q*vec3(2,8,5);
    return length(p)/s;
  }
