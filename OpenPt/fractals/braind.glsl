// braind - by i_dianov
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/braind.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

float de ( vec3 p ) {
  vec3 I=p;
  float e=9.0;
  float d=0.0;
  vec2 uv = p.xy / 2.0;
  for(float j=0;j<PI;j+=PI/3.)
    p=I,
    p.x+=j*4.,
    p.y+=sin(p.x*.5),
    p.z+=sin(p.x)*.5,
    e=min(e,(length(p.yz)-length(uv)/4.)*.8);
    d+=e;
  return d;
}
