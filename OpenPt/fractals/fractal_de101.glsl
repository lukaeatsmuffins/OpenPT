// fractal_de101 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de101.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot101 fractal_de101_rot101
#define sfold101 fractal_de101_sfold101

void rot101(inout vec3 p,vec3 a,float t){
  	a=normalize(a);
  	vec3 u=cross(a,p),v=cross(a,u);
  	p=u*sin(t)+v*cos(t)+a*dot(a,p);
  }
  #define G dot(p,vec2(1,-1)*.707)
  #define V v=vec2(1,-1)*.707
  void sfold101(inout vec2 p){
    vec2 v=vec2(1,-1)*.707;
    float g=dot(p,v);
    p-=(G-sqrt(G*G+.01))*v;
  }
  float de(vec3 p){
    float k=.01;
    for(int i=0;i<8;i++){
      p=abs(p)-1.;
      sfold101(p.xz);
      sfold101(p.yz);
      sfold101(p.xy);
      rot101(p,vec3(1,2,2),.6);
      p*=2.;
    }
    return length(p.xy)/exp2(8.)-.01;
  }
