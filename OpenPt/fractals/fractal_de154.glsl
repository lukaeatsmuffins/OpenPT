// fractal_de154 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de154.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    return (length(vec2((length(vec2(length(p.xy)-1.3,
      length(p.zy)-1.3))-.5), dot(cos(p*12.),sin(p.zxy*12.))*.1))-.02)*.3;
  }
