// fractal_de16 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de16.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    // box fold
    p=abs(p)-15.;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=2.;
    for (int i=0; i<8; i++){
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.);
      float r=-1.55/max(.41,dot(p,p));
      s*=r; p*=r; p-=.5;
    }
    s=abs(s);
    return dot(p,normalize(vec3(1,2,3)))/s;
  }
