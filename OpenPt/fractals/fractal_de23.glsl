// fractal_de23 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de23.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    #define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
    p=abs(p)-3.;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=3.;
    vec3  offset=p*1.2;
    for (float i=0.;i<8.;i++){
      p=1.-abs(p-1.);
      float r=-6.5*clamp(.41*max(1.1/dot(p,p),.8),.0,1.8);
      s*=r; p*=r; p+=offset;
      p.yz*=rot(-1.2);
    }
    s=abs(s);
    float a=20.;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
