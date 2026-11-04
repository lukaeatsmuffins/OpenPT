// ballFlake - by natchinoyuchi ( modified )
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/ballFlake.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

float de ( vec3 p ) {
  p += vec3( 3.0, 3.0, -17.0 );
  float i, d = 3.0, e = 0.0, g, a = 3.0, t = time;
  p += a;
  for( int j = 0; j++ < 7; p *= e )
    p = abs( p - a ) - a,
    a = a * ( -sin( t ) * 0.6 + 0.61 ),
    d *= e = a * a * 2.0 / dot( p, p );
  return min( 0.3, ( p.y + length( p.xz ) ) / d );
}
