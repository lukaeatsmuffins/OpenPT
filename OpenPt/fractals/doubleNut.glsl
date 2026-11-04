// doubleNut - by aiekick
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/doubleNut.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotZ doubleNut_rotZ
#define rotX doubleNut_rotX
#define rotY doubleNut_rotY

mat3 rotZ ( float t ) {
  float s = sin( t );
  float c = cos( t );
  return mat3( c, s, 0., -s, c, 0., 0., 0., 1. );
}

mat3 rotX ( float t ) {
  float s = sin( t );
  float c = cos( t );
  return mat3( 1., 0., 0., 0., c, s, 0., -s, c );
}

mat3 rotY ( float t ) {
  float s = sin( t );
  float c = cos( t );
  return mat3 (c, 0., -s, 0., 1., 0, s, 0, c);
}

float de ( vec3 p ){
  vec2 rm = radians( 360.0 ) * vec2( 0.468359, 0.95317 ); // vary x,y 0.0 - 1.0
  mat3 scene_mtx = rotX( rm.x ) * rotY( rm.x ) * rotZ( rm.x ) * rotX( rm.y );
  float scaleAccum = 1.;
  for( int i = 0; i < 18; ++i ) {
    p.yz = sqrt( p.yz * p.yz + 0.16406 );
    p *= 1.21;
    scaleAccum *= 1.21;
    p -= vec3( 2.43307, 5.28488, 0.9685 );
    p = scene_mtx * p;
  }
  return length( p ) / scaleAccum - 0.15;
}
