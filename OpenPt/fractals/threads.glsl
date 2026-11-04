// threads - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/threads.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D threads_rotate2D

mat2 rotate2D ( float r ) {
  return mat2( cos( r ), sin( r ), -sin( r ), cos( r ) );
}
float de ( vec3 p ) {
  vec3 q=p;
  float d, t = 0.0; // t is time adjustment
  q.xy=fract(q.xy)-.5;
  for( int j=0; j++<9; q+=q )
    q.xy=abs(q.xy*rotate2D(q.z + t))-.15;
    d=(length(q.xy)-.2)/1e3;
  return d;
}
