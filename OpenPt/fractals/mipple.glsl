// mipple - by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/mipple.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float e=2.,s;
  vec3 c=vec3(4,.1,1.5);
  p.y+=1.4;
  for(int j=0;++j<7;p=abs(p)-1.5,e/=s=min(dot(p,p),.4),p/=s);
  return (p.x+p.z)/e;
}
