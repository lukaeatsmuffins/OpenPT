// fractal_de244 - by adapted from code by notargs
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de244.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float a=p.z*.1;
    p.xy *= mat2(cos(a),sin(a),-sin(a),cos(a));
    return abs(.1-length(cos(p.xy)+sin(p.yz)));
  }
