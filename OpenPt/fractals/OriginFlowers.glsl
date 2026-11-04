// OriginFlowers - by Lewpen
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/OriginFlowers.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

//  Origin Flowers by Lewpen (fractals.com)
float de( in vec3 pos ) {
  float fd = 1.0;
  vec3 cs = vec3( -0.7, 0.0, 0.4 );
  float fs = 1.0;
  vec3 fc = vec3( 0.0 );
  vec3 p = pos;
  float dEfactor = 4.0;
  for ( int i=0; i < 24; i++ ) {
    p = 2.0 * clamp( p, -cs, cs ) - p;  //  box folding
    float k = max( 0.58 * fs / dot( p, p ), 1.0 );  //  inversion
    p *= k;
    dEfactor *= k;
    p += fc;  //  julia seed
  }
  return ( abs( length( p.xz * p.z * p.xz ) - 0.5125 ) * 1.0 ) / abs( dEfactor );
}
