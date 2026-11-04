// boxframe - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/boxframe.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ) {
  #define L(p) p.y>p.x?p=p.yx:p
    vec3 k=vec3(5,2,1);
    p.y+=5.4;
    for(int j=0;++j<8;)
      p.xz=abs(p.xz),
      L(p.xz),
      p.z=1.-abs(p.z-.9),
      L(p.xy),
      p.x-=2.,
      L(p.xy),
      p.y+=1.,
      p=k+(p-k)*3.;
    return length(p)/1e4;
  }
