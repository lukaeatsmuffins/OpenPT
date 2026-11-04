// fractal_de153 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de153.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,d=1.,b=1.73;
    vec3 Q=mod(p,b*2.)-b;
    for(int j=0;j++<6;){
      Q=abs(Q);
      if(Q.y>Q.x)Q.xy=Q.yx;
      if(Q.z>Q.x)Q.zx=Q.xz;
      Q*=2.;
      Q.x-=b;
    }
    return (dot(abs(Q),vec3(1)/b)-1.)/64.;
  }
