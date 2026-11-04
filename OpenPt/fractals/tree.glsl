// tree - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/tree.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate2D tree_rotate2D

mat2 rotate2D ( float r ) {
  return mat2( cos( r ), sin( r ), -sin( r ), cos( r ) );
}
float de(vec3 p){
  float e, s = 1.0;
  for( e = p.y += 2.0; s > 0.01; s *= 0.77 )
    p.x=abs(p.x),
    e=min(e,max(abs(p.y-s*.5)-s*.4,length(p.xz))-s*.1),
    p.y-=s,
    p.xz*=rotate2D(1.6),
    p.zy*=rotate2D(.7);
  return e*.8;
}
