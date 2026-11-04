// knitt - by i_dianov
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/knitt.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define coilSlice knitt_coilSlice

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
#define PI (atan(1.)*4.)
#define THREAD_R .035
#define LOOP_R .1
float coilSlice(vec3 p) {
  p.xy+=vec2(LOOP_R,0)*rot(p.z);
  p.x = mod(p.x, 2.*LOOP_R)-LOOP_R;
  return length(p.xy);
}
float de(vec3 p){
  p.z*=10.;
  float tissue = min(
    coilSlice(vec3(p.xy,p.z)),
    coilSlice(vec3(p.xy+vec2(LOOP_R, 0.),p.z+PI))
  )-THREAD_R;
  return tissue*.9;
}
