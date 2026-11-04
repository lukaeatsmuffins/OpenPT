// fractal_de124 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de124.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

float de(vec3 p){
    float i,g,e,s=2.,k;
    vec3 q;
    p=vec3(length(p.xy)-PI,atan(p.y,p.x)*PI,p.z);
    p.yz=mod(p.yz,4.)-2.;
    p=abs(p); q=p;
    for(int j=0;++j<5;)
      p=1.-abs(p-1.),
      p=-p*(k=max(3./dot(p,p),3.))+q, s*=k;
    return length(p.xz)/s;
  }
