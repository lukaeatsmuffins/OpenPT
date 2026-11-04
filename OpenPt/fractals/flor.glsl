// flor - by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/flor.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float e=4.,s;
  for(int j=0;++j<7;p=abs(p)-.9,e/=s=min(dot(p,p),.9),p/=s);
  return length(p.xz)/e;
}
