// fractal_de111 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de111.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float  de(vec3 p){
    float i,g,e=1.,s,l;
    p.z-=9.; s=2.;
    p=abs(p);
    for(int j=0;j++<6;)
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.),
      p*=l=-2./max(.3,sqrt(min(min(p.x,p.y),p.z))),
      p-=2., s*=l;
    return length(p)/s;
  }
