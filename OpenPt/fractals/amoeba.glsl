// amoeba - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/amoeba.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D, PI

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
#define Q(p) p*=rotate2D(round(atan(p.y,p.x)/a)*a),
float de(vec3 p){
  float a=PI/8.0;
  for(int i=0;i++<3;)
    Q(p.yx)p.y-=.8,
    Q(p.zy)p.z-=.8;
  return .5*abs(length(vec2(length(p.xy)-.1,p.z))-.1)+1e-3;
}
