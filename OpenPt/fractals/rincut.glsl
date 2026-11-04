// rincut - by illus0r
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/rincut.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define Rot rincut_Rot
#define sdBox rincut_sdBox
#define sdTorus rincut_sdTorus

#define PI 3.14159265
#define IVORY 1.
#define BLUE 2.
mat2 Rot(float a) {
    float s = sin(a), c = cos(a);
  return mat2(c, -s, s, c);
}
float sdBox( vec3 p, vec3 b ) { vec3 q = abs(p) - b; return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0); }
float sdTorus(vec3 p, float smallRadius, float largeRadius) {
  return length(vec2(length(p.xz) - largeRadius, p.y)) - smallRadius;
}
float de(vec3 p) {
  float t = time;
  vec2 plane = vec2(p.y+0.5, IVORY);
  p.y -= 1.5;
  p.xz *= Rot(t / 4.);
  vec3 pBox = p;
  pBox.xz /= 100.;
  p.y += sin(t);
  float box = sdBox(pBox, vec3(0.05));
  float scale = 0.7;
  vec2 torus = vec2(sdTorus(p, .4, 1.5), BLUE);
  for (int i = 0; i < 9; i++) {
    p.xz = abs(p.xz);
    p.xz -= 1.;
    p /= scale;
    p.yz *= Rot(PI / 2.);
    p.xy *= Rot(PI / 4.);
    vec2 newTorus = vec2(sdTorus(p, .4, 1.5) * pow(scale, float(i+1)), BLUE);
    torus = torus.x < newTorus.x? torus : newTorus;
  }
  torus = box < torus.x ? torus : vec2(box, 0);
  return  torus.x < plane.x? torus.x : plane.x;
}
