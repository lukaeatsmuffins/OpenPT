// fractal_de80 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de80.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float e=1.,B=2.95,H=.9, s=2.;
    p.z=mod(p.z-2.,4.)-2.;
    for(int j=0;j++<8;)
    {
      p=abs(p);
      p.x < p.z?p=p.zyx:p;
      p.x=H-abs(p.x-H);
      p.y < p.z?p=p.xzy:p;
      p.xz+=.1;
      p.y < p.x?p=p.yxz:p;
      p.y-=.1;
    }
    p*=B; p-=2.5; s*=B;
    return length(p.xy)/s-.007;
  }
