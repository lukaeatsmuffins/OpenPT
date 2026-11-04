// teef - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/teef.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float t = 0.0; // adjustment term
  float s = 12.0;
  float e = 0.0;
  for(int j = 0;j++ < 7; p /= e )
    p = mod( p - 1.0, 2.0 ) - 1.0,
    s /= e =dot( p, p );
  e -= abs( p.y ) + sin( atan( p.x, p.z ) * 6.0 + t * 3.0 ) * 0.2 - 0.3;
  return e / s;
}
