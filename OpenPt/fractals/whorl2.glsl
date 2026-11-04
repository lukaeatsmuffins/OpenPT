// whorl2 - by aiekick
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/whorl2.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define getRotZMat whorl2_getRotZMat
#define fractus whorl2_fractus

mat3 getRotZMat(float a){return mat3(cos(a),-sin(a),0.,sin(a),cos(a),0.,0.,0.,1.);}
float fractus(vec3 p) {
  vec2 z = p.xy;
  vec2 c = vec2(0.28,-0.56) * cos(p.z*0.1);
  float k = 1., h = 1.0;
  for (float i=0.;i<8.;i++) {
    h *= 4.*k;
    k = dot(z,z);
    if(k > 4.) break;
    z = vec2(z.x * z.x - z.y * z.y, 2. * z.x * z.y) + c;
  }
  return sqrt(k/h)*log(k);   
}
float de(vec3 p) {
  p *= getRotZMat(cos(p.z*0.2)*2.);
  p.xy = mod(p.xy, 3.5) - 3.5*0.5;
  p *= getRotZMat(cos(p.z*0.6)*2.);
  return fractus(p);
}
