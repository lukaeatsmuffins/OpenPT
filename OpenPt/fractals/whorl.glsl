// whorl - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/whorl.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI, time

float de ( vec3 p ) {
  float e, j, s, k;
  e = 0.0;
  float t = 0.0; // time adjust term 
  float n = 9.0;
  k = t / n;
  p = vec3( log( length( p ) ) ,( atan( p.z, p.x ) - k ) / PI, sin( p.y / n + k ) );
  for ( s = j = 1.0; j++ < n; p = 3.0 - abs( p * e ) )
    p.y -= round( p.y ),
    s *= e = 3.0 / min( dot( p, p ), 1.0 );
  return e = length( p ) / s;
}
