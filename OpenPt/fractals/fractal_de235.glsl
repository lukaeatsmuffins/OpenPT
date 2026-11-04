// fractal_de235 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de235.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec3 Q = fract(p)-.5;
    for(int j=0;j++<5;){
      Q=abs(Q)-.17;
      if(Q.y>Q.x)
        Q.xy=Q.yx;
      if(Q.z>Q.y)
        Q.yz=Q.zy;
      Q.z=abs(Q.z);
      Q-=.17;
      Q*=3.;
    }
    return max((length(Q)-.9)/3e2,1.37-length(p.xy));
  }
