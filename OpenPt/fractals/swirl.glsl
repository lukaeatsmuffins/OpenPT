// swirl - by nimitz/yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/swirl.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ) {
    float i, e, s, g, k = 0.01;
    p.xy *= mat2( cos( p.z ), sin( p.z ), -sin( p.z ), cos( p.z ) );
    e = 0.3 - dot( p.xy, p.xy );
    for( s = 2.0; s < 2e2; s /= 0.6 ) {
      p.yz *= mat2( cos( s ), sin( s ), -sin( s ), cos( s ) );
      e += abs( dot( sin( p * s * s * 0.2 ) / s, vec3( 1.0 ) ) );
    }
    return e;
  }
