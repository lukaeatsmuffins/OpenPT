// fractal_de90 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de90.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float j = 0.5;
    for(p.xz=mod(p.xz,6.)-3.;++j<9.;p=3.*p-.9)
      p.xz=abs(p.xz),
      p.z>p.x?p=p.zyx:p,
      p.y>p.z?p=p.xzy:p,
      p.z--,
      p.x-=++p.y*.5;
    return min(.2,p.x/4e3-.2);
  }
