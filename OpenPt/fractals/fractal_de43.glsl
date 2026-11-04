// fractal_de43 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de43.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

// Prefix this entry's own globals so they can't clash with the host shader.
#define rotate fractal_de43_rotate
#define pmod fractal_de43_pmod

vec3 rotate(vec3 p,vec3 axis,float theta){
    vec3 v = cross(axis,p), u = cross(v, axis);
    return u * cos(theta) + v * sin(theta) + axis * dot(p, axis);
  }

  vec2 pmod(vec2 p, float r){
    float a = mod(atan(p.y, p.x), (M_PI*2) / r) - 0.5 * (M_PI*2) / r;
    return length(p) * vec2(-sin(a), cos(a));
  }

  float de(vec3 p){
    for(int i=0;i<5;i++){
      p.xy = pmod43(p.xy,12.0); p.y-=4.0;
      p.yz = pmod43(p.yz,16.0); p.z-=6.8;
    }
    return dot(abs(p),rotate43(normalize(vec3(2,1,3)),
        normalize(vec3(7,1,2)),1.8))-0.3;
  }
