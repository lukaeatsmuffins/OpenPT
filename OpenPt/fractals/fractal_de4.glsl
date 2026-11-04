// fractal_de4 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de4.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p0 ){
    vec4 p = vec4(p0, 1.);
    for(int i = 0; i < 8; i++){
      if(p.x > p.z)p.xz = p.zx;
      if(p.z > p.y)p.zy = p.yz;
      p = abs(p);
      p.xyz = mod(p.xyz-1., 2.)-1.;
      p*=1.23;
    }
    p/=p.w;
    return abs(p.y)*0.25;
  }
