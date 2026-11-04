// snoflake3d - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/snoflake3d.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de ( vec3 p ){
  float e = 1.;
  for( int i=0;i++<9; ){
    p = abs( p ) - .2;
    p = p.x > p.y ? p.zxy : p.zyx;
    p *= 2.0;
    e *= 2.0;
    p.xz *= rotate2D( 2.6 );
    p.yx = abs( p.yx ) - 4.0;
  }
  p /= e;
  return e = length( p ) * .8 - .01;
}
