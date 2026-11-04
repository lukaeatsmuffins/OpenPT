// fractal_de114 - by adapted from code by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de114.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

float de(vec3 p){
    float k = M_PI*2.;
    vec3 v = vec3(0.,3.,fract(k));
    return (length(cross(cos(p+v),p.zxy))-0.4)*0.2;
  }
