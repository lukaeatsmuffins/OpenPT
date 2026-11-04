// stairs - by Kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/stairs.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de ( vec3 P ) {
  vec3 Q;
  float a, d = min( ( P.y - abs( fract( P.z ) - 0.5f ) ) * 0.7f, 1.5f - abs( P.x ) );
  for( a = 2.0f; a < 6e2f; a += a )
    Q = P * a,
    Q.xz *= rotate2D( a ),
    d += abs( dot( sin( Q ), Q - Q + 1.0f ) ) / a / 7.0f;
  return d;
}
