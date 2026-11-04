// Lewpen_snowflake - by Lewpen
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/Lewpen_snowflake.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

//  Snowflake by Lewpen (fractals.com)
float de( in vec3 pos ) {
  //  PARAM: Offset distance for each iteration of spheres
  float Distance = 1.1428;
  //  PARAM: Scale factor for each iteration of spheres
  float Scale = 0.3868138;
  float r = length( pos ) - 1.0;
  float e = 1.0;
  float oScale = 1.0 / Scale;
  for ( int i = 0; i < 20; i++ ) {
    vec3 v;
    if ( abs( pos.x ) > abs( pos.y ) ) {
      if ( abs( pos.x ) > abs( pos.z ) ) {
        v = vec3( 1.0, 0.0, 0.0 );
      } else {
        v = vec3( 0.0, 0.0, 1.0 );
      }
    } else {
      if ( abs( pos.y ) > abs( pos.z ) ) {
        v = vec3( 0.0, 1.0, 0.0 );
      } else {
        v = vec3( 0.0, 0.0, 1.0 );
      }
    }
    pos = abs( abs( pos ) - Distance * v );
    pos *= oScale;
    e *= Scale;
    r = min( r, e * ( length( pos ) - 1.0 ) );
  }
  return r;
}
