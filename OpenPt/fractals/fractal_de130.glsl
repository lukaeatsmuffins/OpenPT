// fractal_de130 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de130.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define F1(s)p.s=abs(p.s)-1.
    p+=vec3(0,3.8,5.);
    vec3 q=p;
    p=mod(p,vec3(8,8,2))-vec3(4,4,1);
    F1(yx); F1(yx); F1(xz);
    return min(length(cross(p,vec3(.5)))-.03,length(p.xy)-.05);
  }
