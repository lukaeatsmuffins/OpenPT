// heartcube - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/heartcube.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float e,s;
  e=s=2.;
  for(int i=0;i++<5;s*=1.8,p*=1.8)
    p=abs(p)-.2,
    p=p.x<p.y?p.zxy:p.zyx,
    e=min(e,(length(vec2(length(p.xy)-.4,p.z))-.1)/s);
  return e;
}
