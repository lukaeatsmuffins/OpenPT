// feeingers - by stduhpf
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/feeingers.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float scale = 1.0;
  float orb = 10000.0; // orbit term 1
  for ( int i = 0; i < 6; i++ ) {
    p = -1.0 + 2.0 * fract( 0.5 * p + 0.5 );
    p -= sign( p ) * 0.1;
    float a = float( i ) * acos( -1.0 ) / 4.0;
    p.xz *= mat2( cos( a ), sin( a ), -sin( a ), cos( a ) );
    float r2 = dot( p, p );
    float k = 0.95 / r2;
    p *= k;
    scale *= k;
    orb = min( orb, r2 );
  }
  float d1 = sqrt( min( min( dot( p.xy, p.xy ), dot( p.yz, p.yz ) ), dot( p.zx, p.zx ) ) ) - 0.02;
  float d2 = abs( p.y );
  float dmi = d2;
  float adr = 0.7 * floor( ( 0.5 * p.y + 0.5 ) * 8.0 ); // orbit term 2
  if ( d1 < d2 ) {
    dmi = d1;
    adr = 0.0;
  }
  return 0.5 * dmi / scale;
}
