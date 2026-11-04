// bug - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/bug.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  vec3 q = vec3( -1.0, -1.0, 5.0 );
  vec3 d = vec3( 0.0 );
  float e = 0.0, s, u;
  e = s = 1.0;
  for( int j = 0; j++ < 6; p = cos( p ) - 0.7)
    s /= u = dot( p, p ),
    p /= -u,
    p.y = 1.72 - p.y,
    p += 0.7,
    e = min( e, p.y / s );
   return e;
}
