// sinDungeon - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/sinDungeon.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
  p = asin( sin( p ) ) - vec3( 2., -3., 0. );
  float e=0., s=2.;
  for(int i=0;i++<8;p=p*e-vec3(1,3,7))
    p=abs(p),
    p=p.x<p.y?p.zxy:p.zyx,
    s*=e=2./clamp(dot(p,p),.2,1.);
  return e=abs(length(p-clamp(p,-5.,5.))-5.)/s+1e-5;
}
