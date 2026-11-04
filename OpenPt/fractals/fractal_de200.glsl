// fractal_de200 - by evilryu
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de200.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define ry fractal_de200_ry
#define plane fractal_de200_plane
#define menger_spone fractal_de200_menger_spone

void ry(inout vec3 p, float a){
    float c,s;vec3 q=p;
    c = cos(a); s = sin(a);
    p.x = c * q.x + s * q.z;
    p.z = -s * q.x + c * q.z;
  }
  float plane(vec3 p, float y) {
    return length(vec3(p.x, y, p.z) - p);
  }
  float menger_spone(in vec3 z0){
    z0=z0.yzx;
    vec4 z=vec4(z0,1.0);
    vec3 offset =0.83*normalize(vec3(3.4,2., .2));
    float scale = 2.;
    for (int n = 0; n < 8; n++) {
      z = abs(z);
      ry(z.xyz, 1.5);
      if (z.x < z.y)z.xy = z.yx;
      if (z.x < z.z)z.xz = z.zx;
      if (z.y < z.z)z.yz = z.zy;
      ry(z.xyz, -1.21);
      z = z*scale;
      z.xyz -= offset*(scale-1.0);
    }
    return (length(max(abs(z.xyz)-vec3(1.0),0.0))-0.01)/z.w;
  }
  float de(vec3 p){
    float d1 = plane(p, -0.5);
    float d2 = menger_spone(p+vec3(0.,-0.1,0.));
    float d = d1;
    vec3 res = vec3(d1, 0., 0.);
    if(d > d2){
      d = d2;
      res = vec3(d2, 1., 0.0);
    }
    return res.x;
  }
