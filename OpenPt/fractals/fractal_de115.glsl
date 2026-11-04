// fractal_de115 - by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de115.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){  (distance bound doesn't hold)
    vec3 v=vec3(0,1.5,6.3);
    return min(6.-length((p-v).xy+sin(p.yx)),
      dot(cos(p),sin(p.yzx)))+sin(sin(p.z*3.5)+v.z)*.1+1.;
  }
