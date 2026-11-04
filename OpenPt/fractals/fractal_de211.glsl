// fractal_de211 - by shane
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de211.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot2 fractal_de211_rot2

mat2 rot2(in float a){ float c = cos(a), s = sin(a); return mat2(c, s, -s, c); }
  float de(vec3 p){
    float d = 1e5;
    const int n = 3;
    const float fn = float(n);
    for(int i = 0; i < n; i++){
      vec3 q = p;
      float a = float(i)*fn*2.422; //*6.283/fn
      a *= a;
      q.z += float(i)*float(i)*1.67; //*3./fn
      q.xy *= rot2(a);
      float b = (length(length(sin(q.xy) + cos(q.yz))) - .15);
      float f = max(0., 1. - abs(b - d));
      d = min(d, b) - .25*f*f;
    }
    return d;
  }
