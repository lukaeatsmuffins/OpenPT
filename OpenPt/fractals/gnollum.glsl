// gnollum - by Kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gnollum.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de( vec3 p ){
  vec3 Q, U = vec3( 1.0f );
  float d=1.0, a=1.0f;
  d = min( length( fract( p.xz) -0.5f ) - 0.2f, 0.3f - abs( p.y - 0.2f ) );
  for( int j = 0; j++ < 9; a += a )
    Q = p * a * 9.0f,
    Q.yz *= rotate2D( a ),
    d += abs( dot( sin( Q ), U ) ) / a * 0.02f;
  return d * 0.6f;
}
