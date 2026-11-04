// gonuts - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gonuts.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
#define Q(p) p*=rot(round(atan(p.y,p.x)/a)*a),
float de(vec3 p){
  float a = PI/8.0;
  for(int i=0;i++<5;)
    Q(p.yx)p.y-=1.,
    Q(p.zy)p.z-=1.;
  return.5*abs(length(p+p.zxy)-.05)+1e-3;
}
