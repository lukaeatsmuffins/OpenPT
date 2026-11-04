// rifs - by illus0r
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/rifs.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

#define PI (atan(1.)*4.)
#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
float de(vec3 p){
  p.yz *= rot(-time);
  p.xz *= rot(-time);
  float s = 1.;
  float d, dPrev, dPrePrev;
  for(int i = 0; i++ < 5;) {
    dPrePrev = dPrev;
    dPrev = d;
    p.xz *= rot(time-3.14/6. + float(i));
    p.yz *= rot(time+3.14/6. + float(i));
    p = abs(p);
    p -= .4;
    p *= 2.;
    s *= 2.;
    d = (length(vec2(length(p)-.9, p.z))-.4)/s;
  }
  return (length(vec2(d, dPrePrev))-.01)*.5;
}
