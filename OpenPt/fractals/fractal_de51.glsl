// fractal_de51 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de51.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

#define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
  float de(vec3 p){
    for(int j=0;++j<8;)
      p.z-=.3,
      p.xz=abs(p.xz),
      p.xz=(p.z>p.x)?p.zx:p.xz,
      p.xy=(p.y>p.x)?p.yx:p.xy,
      p.z=1.-abs(p.z-1.),
      p=p*3.-vec3(10,4,2);

    return length(p)/6e3-.001;
  }
