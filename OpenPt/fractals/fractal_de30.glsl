// fractal_de30 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de30.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define pmodg fractal_de30_pmodg

#define TAUg atan(1.)*8.
  vec2 pmodg(vec2 p, float n){
    float a=mod(atan(p.y, p.x),TAUg/n)-.5 *TAUg/n;
    return length(p)*vec2(sin(a),cos(a));
  }

  float de( vec3 p ){
    for(int i=0;i<4;i++){
      p.xy = pmodg(p.xy,10.);  p.y-=2.;
      p.yz = pmodg(p.yz, 12.); p.z-=10.;
    }
    return dot(abs(p),normalize(vec3(13,1,7)))-.7;
  }
