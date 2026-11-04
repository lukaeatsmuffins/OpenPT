// tokamak - by i_dianov
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/tokamak.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot tokamak_rot

mat2 rot( float r ){
  return mat2(cos(r), sin(r), -sin(r), cos(r));
}
float de ( vec3 p ) {
  p.z+=.6;
  p.xz*=rot(3.141*2.*time/(19.));
  p*=3.;
  p=vec3(atan(p.x,p.z)*3.025,p.y,length(p.xz)-4.);
  p.yx*=rot(3.141/2.);
  p=vec3(atan(p.x,p.z)*3.025,p.y,length(p.xz)-5.);
  p.z+=2.;
  p.xy = mod(p.xy,1.)-.5;
  return .2*(length(p)-1.);
}
