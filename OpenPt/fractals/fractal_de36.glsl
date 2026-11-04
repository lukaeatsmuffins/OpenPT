// fractal_de36 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de36.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ) {
    float itr=10.,r=0.1;
    p=mod(p-1.5,3.)-1.5;
    p=abs(p)-1.3;
    if(p.x < p.z)p.xz=p.zx;
    if(p.y < p.z)p.yz=p.zy;
    if(p.x < p.y)p.xy=p.yx;
    float s=1.;
    p-=vec3(.5,-.3,1.5);
  	for(float i=0.;i++ < itr;) {
  		float r2=2./clamp(dot(p,p),.1,1.);
  		p=abs(p)*r2;
  		p-=vec3(.7,.3,5.5);
  		s*=r2;
  	}
    return length(p.xy)/(s-r);
  }
