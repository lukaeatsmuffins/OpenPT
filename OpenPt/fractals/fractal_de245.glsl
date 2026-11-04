// fractal_de245 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de245.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): M_PI

#define D (dot(sin(Q),cos(Q.yzx))+1.3)
  float de(vec3 p){
  	vec3 Q;
  	float i,d=1.;
  	Q=p, d=D, Q.x+=M_PI, d=min(d,D);
  	Q.y+=M_PI;
    d=min(d,D);
  	Q*=30.;
  	d=max(abs(d),(abs(D-1.3)-.5)/30.);
  	return d*.6;
  }
