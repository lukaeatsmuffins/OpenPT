// fractal_de39 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de39.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

// Prefix this entry's own globals so they can't clash with the host shader.
#define SMin1 fractal_de39_SMin1
#define fold fractal_de39_fold
#define sdTorus fractal_de39_sdTorus

#define sabs(a) sqrt(a * a + 0.005)
  #define smin(a,b) SMin1(a,b,0.0003)
  #define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
  float SMin1(float a, float b, float k){
    return a + 0.5 * ((b-a) - sqrt((b-a) * (b-a) + k));
  }
  vec2 fold(vec2 p, int n){
    p.x=sabs(p.x);
    vec2 v=vec2(0,1);
    for(int i=0;i < n;i++){
      p-=2.0*smin(0.0,dot(p,v))*v;
      v=normalize(vec2(v.x-1.0,v.y));
    }
    return p;
  }
  float sdTorus( vec3 p, vec2 t ){
    vec2 q = vec2(length(p.xz)-t.x,p.y);
    return length(q)-t.y;
  }
  float de(vec3 p){
    float A=5.566;
    float c=7.0;
    p=mod(p,c)-c*0.5;
    p.xz=fold(p.xz,5);
    for(int i=0;i<5;i++){
      p.xy=abs(p.xy)-2.0;
      p.yz=abs(p.yz)-2.5;
      p.xy*=rot(A);
      p.yz*=rot(A*0.5);
      p=abs(p)-2.0;
    }
    vec2 s=vec2(0.05,0.02);
    float h=0.08;
    float de=1.0;
    vec3 q=p;
    q.xy=fold(q.xy,5);
    q.y-=2.;
    q.x-=clamp(q.x,-h,h);
    de=min(de,sdTorus(q,s));
    q=p;
    q.xy*=rot(M_PI/exp2(5.0));
    q.xy=fold(q.xy,5);
    q.y-=2.0;
    q.x-=clamp(q.x,-h,h);
    de=min(de,sdTorus(q.xzy,s));
    return de;
  }
