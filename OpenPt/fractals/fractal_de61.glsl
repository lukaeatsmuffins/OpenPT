// fractal_de61 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de61.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
  float de(vec3 p){
    p=abs(p)-3.;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=2.; vec3 off=p*.5;
    for(int i=0;i<12;i++){
      p=1.-abs(p-1.);
      float k=-1.1*max(1.5/dot(p,p),1.5);
      s*=abs(k); p*=k; p+=off;
      p.zx*=rot(-1.2);
    }
    float a=2.5;
    p-=clamp(p,-a,a);
    return length(p)/s;
  }
