// fractal_de112 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de112.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,s;
    vec3 q=p; s=5.;
    for(int j=0;j++<6;s*=e)
      p=sign(p)*(1.7-abs(p-1.7)),
      p=p*(e=8./clamp(dot(p,p),.3,5.))+q-vec3(.8,12,.8);
    return length(p.yz)/s;
  }
