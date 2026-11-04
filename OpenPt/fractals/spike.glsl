// spike - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/spike.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D spike_rotate2D

mat2 rotate2D ( float r ) {
  return mat2( cos( r ), sin( r ), -sin( r ), cos( r ) );
}

float de ( vec3 p ) {
  float e = 1.0, g;
  p = asin( sin( p ) );
  for( int i = 0; i++ < 7; ){
    p = abs( p ) - 0.1;
    p = p.x > p.y ? p.zxy : p.zyx;
    p *= 2.0;
    e *= 2.0;
    p.xz *= rotate2D( 2.8 );
    p.yx = abs( p.yx ) - 4.0;
  }
  p /= e;
  return e = abs( p.z ) * 0.6 - 0.02;
}
