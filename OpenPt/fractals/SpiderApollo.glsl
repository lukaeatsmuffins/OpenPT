// SpiderApollo - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/SpiderApollo.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

#define rot(a)mat2(cos(a),sin(a),-sin(a),cos(a))
float de( vec3 p ) {
  float s = 4.0;
  for( int i = 0; i < 8; i++ ) {
    p.xz *= rot( 3.1415 / 3.0 );
    p = mod( 1.0 - p, 2.0 ) - 1.0;
    float r2 = ( 4.0 / 3.0 ) / dot( p, p );
    p *= r2;
    s *= r2;
  }
  return length( p ) * abs( p.y ) / s;
}
