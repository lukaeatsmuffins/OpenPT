// fractal_de201 - by plento
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de201.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sdBox fractal_de201_sdBox
#define rotate fractal_de201_rotate

float sdBox( vec3 p, vec3 b ){
    vec3 d = abs(p) - b;
    return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
  }

  vec2 rotate(vec2 k,float t){
    return vec2(cos(t) * k.x - sin(t) * k.y, sin(t) * k.x + cos(t) * k.y);
  }

  float de(vec3 pos){
    vec3 b = vec3(0.9 , 4.5, 0.70);
    float p = sin(pos.z * 0.1) * 2.0;

    pos = vec3(rotate(pos.xy, p), pos.z);
    pos.y += 1.2;
    pos = mod(pos, b) -0.5 * b;
    pos.x *= sin(length(pos * 1.8) * 2.0) * 1.4;

    return sdBox(pos - vec3(0.0, 0.0, 0.0), vec3(0.4));
  }
