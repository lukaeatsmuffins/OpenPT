// sonolith - by zackpudil
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/sonolith.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  p.xy = mod( p.xy + 1.0, 2.0 ) - 1.0;
  p.z = abs( p.z ) - 0.75;
  vec4 q = vec4( p, 1.0 );
  for ( int i = 0; i < 15; i++ ) {
    q.xyz = abs( q.xyz ) - vec3( 0.3, 1.0, -0.0 );
    q = 2.0 * q / clamp( dot( q.xyz, q.xyz ), 0.5, 1.0 ) - vec4( 1.0, 0.0, 0.3, 0.0 );
  }
  return abs(q.x + q.y + q.z)/q.w;
}
