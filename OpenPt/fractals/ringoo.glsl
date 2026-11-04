// ringoo - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/ringoo.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float i = 0.0f;
  float u = 0.0f;
  float S = 6.0f;
  p--;
  for ( int j = 0; j++ < 8; p = abs( ++p ) - 1.0f )
    p.z =- p.z,
    u = dot( p, p ) * 0.6f,
    S /= u + 0.001f, // prevent divide-by-zero
    p /= u + 0.001f;
  return ( length( p.xz ) + p.y ) / S;
}
