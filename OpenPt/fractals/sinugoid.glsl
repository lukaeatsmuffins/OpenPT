// sinugoid - by catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/sinugoid.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  #define F d=max(d,(1.2-length(sin(p*s)))/s);p+=s*=1.3
  float l=.1,d=l,s,i;
  d=0.;
  s=1.;
  F;
  F;
  l+=F;
  F*5.;
  F;
  #undef F
  return d;
}
