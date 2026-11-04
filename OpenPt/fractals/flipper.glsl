// flipper - by Adapted from code by Kali
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/flipper.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

float de( vec3 p ) {
    float t = 160.0; // designed as a time varying term
    p = p.zxy;
    float a = 1.5 + sin( t * 0.3578 ) * 0.5;
    p.xy = p.xy * mat2( cos( a ), sin( a ), -sin( a ), cos( a ) );
    p.x *= 0.75;
    vec3 ani;
    ani = vec3( sin( t ), sin( t ), cos( t ) ) * 0.6;
    p += sin( p * 3.0 + t * 6.0 ) * 0.04;
    vec3 pp = p;
    float l;
    vec3 rv = vec3( 0.5, -0.05, -1.0 );
    for ( int i = 0; i < 20; i++ ) {
      p.xy = abs( p.xy );
      p = p * 1.25 + vec3( -3.0, -1.5, -0.5 );
      vec3 axis = normalize( rv + ani );
      float angle = ( 40.0 + sin( t ) * 10.0 ) * 0.017;
      p = mix( dot( axis, p ) * axis, p, cos( angle ) ) + cross( axis, p ) * sin( angle ); 
      l = length( p );
    }
    return l * pow( 1.25, -20.0 ) - 0.1;
  }
