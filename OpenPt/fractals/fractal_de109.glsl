// fractal_de109 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de109.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    float h,d=1.,i,u,s, t = 0.8; // vary t for different behavior
    p+=vec3(1,1,sin(t/4.)*3.);
    s=2.;
    for(int j=0;j<9;j++){
      p.xy*=rotate2D(t/4.);
      u=4./3./dot(p,p);
      s*=u;
      p=mod(1.-p*u,2.)-1.;
    }
    return (length(p)/s);
  }
