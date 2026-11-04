// knittt - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/knittt.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

#define _(a) mat2(cos(a),sin(a),-sin(a),cos(a))
#define q(p) length(vec2(mod(p.x,.4)-.2,p.y+sin(t)))
#define R(x) vec2(.3,0)*_((p.z+t)*9.+x)
float de(vec3 p){
  float t=time;
  return min(q((p.xy+R(0.))),q((p.xy+R(3.14))))*.2;
}
