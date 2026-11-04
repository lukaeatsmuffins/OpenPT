// rolls - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/rolls.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float s,e;
  vec3 q=p*2.;
  s=3.;
  for(int j=0;j++<8;s*=e)
    p=sign(p)*(1.-abs(abs(p-2.)-1.)),
    p=p*(e=6./min(dot(p,p)+.3,3.))+q-vec3(3,1,12);
  return length(p)/s;
}
