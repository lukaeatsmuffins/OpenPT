// fractal_de147 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de147.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float e=2., s=0., z=0.;
    for(int j=0;++j<6;p=abs(p)-1.5,e/=s=min(dot(p,p),.75),p/=s);
    z+=length(p.xz)/e;
    return z;
  }
