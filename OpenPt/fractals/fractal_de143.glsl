// fractal_de143 - by adapted from code by alia
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de143.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 q=fract(p)-.5;
    float f=-length(p.xy)+2., g=length(q)-.6;
    return max(f,-g);
  }
