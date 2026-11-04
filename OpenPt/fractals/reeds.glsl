// reeds - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/reeds.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float e,s;
  e=s=2.;
  for(int i=0;i++<6;s*=2.,p*=2.)
    p=.1-abs(abs(p)-.2),
    p=p.x<p.y?p.zxy:p.zyx,
    e=min(e,(length(vec2(length(p.xy)-1.,p.z)))/s+5e-4);
  return e;
}
