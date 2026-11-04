// warpedKlein - by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/warpedKlein.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float l, e, v;
  l=1.;
  for(int j=0;j++<8;l*=v)
    p=2.*clamp(p,-.8,.9)-p,
    p*=v=max(.9/dot(p,p),.7),
    p+=.13;
  return e=.1*p.y/l;
}
