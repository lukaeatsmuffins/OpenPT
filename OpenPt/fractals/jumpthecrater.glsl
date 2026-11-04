// jumpthecrater - by michael0884
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/jumpthecrater.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

vec3 orbitColor;
float de( vec3 p ) {
// Jump the crater
  float scale = 1.8f;
  float angle1 = -0.12f;
  float angle2 = 0.5f;
  vec3 shift = vec3( -2.12f, -2.75f, 0.49f );
  vec3 color = vec3( 0.42f, 0.38f, 0.19f );
  vec2 a1 = vec2(sin(angle1), cos(angle1));
  vec2 a2 = vec2(sin(angle2), cos(angle2));
  mat2 rmZ = mat2(a1.y, a1.x, -a1.x, a1.y);
  mat2 rmX = mat2(a2.y, a2.x, -a2.x, a2.y);
  float s = 1.0;
  orbitColor = vec3( 0.0f );
  for (int i = 0; i <11; ++i) {
    p.xyz = abs(p.xyz);
    p.xy *= rmZ;
    p.xy += min( p.x - p.y, 0.0 ) * vec2( -1., 1. );
    p.xz += min( p.x - p.z, 0.0 ) * vec2( -1., 1. );
    p.yz += min( p.y - p.z, 0.0 ) * vec2( -1., 1. );
    p.yz *= rmX;
    p *= scale;
    s *= scale;
    p.xyz += shift;
    orbitColor = max( orbitColor, p.xyz * color);
  }
  vec3 d = abs( p ) - vec3( 6.0f );
  return ( min( max( d.x, max( d.y, d.z ) ), 0.0 ) + length( max( d, 0.0 ) ) ) / s;
}
