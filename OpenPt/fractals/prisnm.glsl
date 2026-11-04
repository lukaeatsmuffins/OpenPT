// prisnm - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/prisnm.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

float de ( vec3 p ) {
#define R(p,a,t) mix(a*dot(p,a),p,cos(t))+sin(t)*cross(p,a)
#define H(h) (cos((h)*6.3+vec3(0,23,21))*.5+.5)
  
  float i=0., s, e, g=0.0;
  float t = time;
  vec4 pp=vec4(p,.07);
  pp.z-=0.5;
  pp.xyz=R(pp.xyz,normalize(H(t*.1)),t*.2);
  s=2.0;
  for(int j=0;j++<6;)
    pp=.02-abs(pp-.1),
    s*=e=max(1./dot(pp,pp),1.3),
    pp=abs(pp.x<pp.y?pp.wzxy:pp.wzyx)*e-1.3;
    g+=e=abs(length(pp.xz*pp.wy)-.02)/s+1e-4;
  return g;
#undef R
#undef H
}
