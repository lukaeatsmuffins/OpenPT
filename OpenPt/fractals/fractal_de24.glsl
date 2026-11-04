// fractal_de24 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de24.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ) {
    #define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
    p=abs(p)-2.;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=2.5;
    vec3 off=p*2.8;
    for (float i=0.;i<6.;i++) {
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.);
      float r=-11.*clamp(.8*max(2.5/dot(p,p),.2),.3,.6);
      s*=r; p*=r; p+=off;
      p.yz*=rot(2.1);
    }
    s=abs(s);
    float a=30.;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
