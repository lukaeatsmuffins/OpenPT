// ringo - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/ringo.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  p -= round( p );
  float s = 3.0;
  float e = 0.0;
  for( int i=0;i++ < 8; p = p / e + 2.0 )
    p = abs( p ) - 1.5,
    s /= e = min( dot( p, p ), 0.4 );
  return e = length( p.yz ) / s;
}
