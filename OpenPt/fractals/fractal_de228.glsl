// fractal_de228 - by 
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de228.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float s = 1.;
    escape = 0.;
    float t = 999.;
    for(int i = 0; i < 12; i++){
      p=abs(p);
      p.yz = (p.y > p.z)?p.zy:p.yz;
      p.xz = (p.x > p.z)?p.zx:p.xz;
      p.yx = (p.y > p.x)?p.xy:p.yx;
      s *= 4.0/clamp(dot(p,p),0., 11.);
      p *= 4.0/clamp(dot(p,p), 0., 11.);
      p = vec3(2.,4.,2.)-abs(p-vec3(2.,4.,2.));
      t = min(t, (abs(p.x)/s)*0.76);
      escape += exp(-0.4*dot(p,p));
    }
    return t;
  }
