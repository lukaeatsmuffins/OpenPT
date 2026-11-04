// fractal_de234 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de234.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// very compact menger sponge expression
  float de(vec3 p){
    float a=1.;
    for(int i=0;i<5;i++){ // adjust iteration count here
      p=abs(p)-1./3.;
      if(p.y>p.x)p.xy=p.yx;
      if(p.z>p.y)p.yz=p.zy;
      p.z=abs(p.z);
      p*=3.;
      p-=1.;
      a*=3.;
    }
    return length(max(abs(p)-1.,0.))/a;
  }
