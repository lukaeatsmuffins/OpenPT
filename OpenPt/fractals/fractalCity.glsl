// fractalCity - by Leon Denise
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractalCity.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot fractalCity_rot

mat2 rot ( float a ) { return mat2( cos( a ), -sin( a ), sin( a ), cos( a ) ); }
  float de ( vec3 p ) {
    float scene = 100.;
    float t = 1000; // arbitrary value
    float falloff = 1.0;
    for ( float index = 0.; index < 8.; ++index ) {
      p.xz *= rot( t / falloff );
      p = abs( p ) - 0.5 * falloff;
      scene = min( scene, max( p.x, max( p.y, p.z ) ) );
      falloff /= 1.8;
    }
    return -scene;
  }
