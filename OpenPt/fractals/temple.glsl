// temple - by sxolastikos
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/temple.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de ( vec3 p ) {
  float d;
  p.z-=6.;
  p.yz*=rotate2D(1.57);
  for(int j=0;j++<4;)
    p=abs(fract(abs(p))-.1),
    d=dot(p.z,max(p.x,p.y))-.001,
    d-=.8*min(d,dot(p,p-vec3(-1)));
  return d*4.;
}
