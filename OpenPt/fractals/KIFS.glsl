// KIFS - by Adapted from code by P_Malin
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/KIFS.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define SetRotQuat KIFS_SetRotQuat
#define SetRot KIFS_SetRot

mat3 SetRotQuat ( const in vec4 q ) {
    vec4 qSq = q * q;
    float xy2 = q.x * q.y * 2.0;
    float xz2 = q.x * q.z * 2.0;
    float yz2 = q.y * q.z * 2.0;
    float wx2 = q.w * q.x * 2.0;
    float wy2 = q.w * q.y * 2.0;
    float wz2 = q.w * q.z * 2.0;
    return mat3 (
      qSq.w + qSq.x - qSq.y - qSq.z, xy2 - wz2, xz2 + wy2,
      xy2 + wz2, qSq.w - qSq.x + qSq.y - qSq.z, yz2 - wx2,
      xz2 - wy2, yz2 + wx2, qSq.w - qSq.x - qSq.y + qSq.z );
  }
  mat3 SetRot ( vec3 vAxis, float fAngle ) {
    return SetRotQuat( vec4( normalize( vAxis ) * sin( fAngle ), cos( fAngle ) ) ); 
  }
  float de( vec3 p ) {
    vec2 ax = vec2( 0.2, 0.7 ); // pick two values in the range 0,1
    vec3 vRotationAxis = vec3( ax.x, 1.0, ax.y );
    float fRotationAngle = length( vRotationAxis );

    mat3 m = SetRot( vRotationAxis, fRotationAngle );
    float fTrap = 30.0;
    float fTotalScale = 1.0;
    const float fScale = 1.25;
    vec3 vOffset = vec3( -1.0, -2.0, -0.2 );
    for( int i = 0; i < 16; i++ ) {
      p.xyz = abs( p.xyz );
      p *= fScale;
      fTotalScale *= fScale;
      p += vOffset;
      p.xyz = ( p.xyz ) * m;
      float fCurrDist = length( p.xyz ) * fTotalScale;
      // float fCurrDist = max(max( p.x,  p.y ),  p.z ) * fTotalScale;
      // float fCurrDist = dot( p.xyz, p.xyz ); // * fTotalScale;
      fTrap = min( fTrap, fCurrDist );
    }
    float l = length( p.xyz ) / fTotalScale;
    float fDist = l - 0.1;
    // return vec2(fDist, fTrap);
    return fDist;
  }
