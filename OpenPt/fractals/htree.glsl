// htree - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/htree.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    vec3 P=p, Q, b=vec3( 4, 2.8, 15 );
    float i, d=1., a;
    Q = mod( P, b ) - b * 0.5;
    d = P.z - 6.0;
    a = 1.3;
    for( int j = 0; j++ < 11; )
      d = min( d, length( max( abs( Q ) - b.zyy / 13.0, 0.0 ) ) / a ),
      Q = vec3( Q.y, abs( Q.x ) - 1.0, Q.z + 0.3 ) * 1.4,
      a *= 1.4;
    return d;
  }
