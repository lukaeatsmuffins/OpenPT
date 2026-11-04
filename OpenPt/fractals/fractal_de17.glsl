// fractal_de17 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de17.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sFold90 fractal_de17_sFold90

void sFold90( inout vec2 p ){
    vec2 v=normalize(vec2(1,-1));
    float g=dot(p,v);
    p-=(g-sqrt(g*g+1e-1))*v;
  }

  float de( vec3 p ){
  #define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
    p=abs(p)-1.8;
    sFold90(p.zy);
    sFold90(p.xy);
    sFold90(p.zx);
    float s=2.;
    vec3  offset=p*.5;
    for(int i=0;i<8;i++){
      p=1.-abs(p-1.);
      float r=-1.3*max(1.5/dot(p,p),1.5);
      s*=r; p*=r; p+=offset;
      p.zx*=rot(-1.2);
    }
    s=abs(s); float a=8.5;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
