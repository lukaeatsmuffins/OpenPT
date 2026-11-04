// fractal_de102 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de102.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate3D

float de(vec3 p){
    #define V vec2(.7,-.7)
    #define G(p)dot(p,V)
    float i=0.,g=0.,e=1.;
    float t = 0.34; // change to see different behavior
    for(int j=0;j++<8;){
      p=abs(rotate3D(0.34,vec3(1,-3,5))*p*2.)-1.,
      p.xz-=(G(p.xz)-sqrt(G(p.xz)*G(p.xz)+.05))*V;
    }
    return length(p.xz)/3e2;
  }
