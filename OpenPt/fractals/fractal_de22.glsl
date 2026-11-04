// fractal_de22 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de22.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    float s=12.; p=abs(p);
    vec3 offset=p*3.;
    for (float i=0.; i<5.; i++){
      p=1.-abs(p-1.);
      float r=-5.5*clamp(.3*max(2.5/dot(p,p),.8),0.,1.5);
      p*=r; p+=offset; s*=r;
    }
    s=abs(s); p=abs(p)-3.;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float a=3.;
    p-=clamp(p,-a,a);
    return length(p.xz)/s;
  }
