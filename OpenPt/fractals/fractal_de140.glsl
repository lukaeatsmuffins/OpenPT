// fractal_de140 - by yuruyurau
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de140.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define b(p)length(max(abs(mod(p,.8)-.4)-.05,0.))
    vec3 l;
    p=cos(p)-vec3(.3), p.yx*=mat2(cos(.8+vec4(0,3,5,0)));
    return min(min(b(p.xy),b(p.xz)),b(p.yz));
  }
