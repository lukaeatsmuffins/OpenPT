// fractal_de249 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de249.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q;
    Q=p;
    Q.xy=vec2(atan(Q.x,Q.y)/.157,length(Q.xy)-3.);
    Q.zx=fract(Q.zx)-.5;
    return min(min(length(Q.xy),length(Q.yz))-.2,p.y+.5);
  }
