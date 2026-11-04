// fractal_de223 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de223.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p0){
    vec4 p = vec4(p0,3.);
    escape = 0.;
    p*= 2./min(dot(p.xyz,p.xyz),30.);
    for(int i = 0; i < 14; i++){
      p.xyz = vec3(2.,4.,2.)-(abs(p.xyz)-vec3(2.,4.,2.));
      p.xyz = mod(p.xyz-4., 8.)-4.;
      p *= 9./min(dot(p.xyz,p.xyz),12.);
      escape += exp(-0.2*dot(p.xyz,p.xyz));
    }
    p.xyz -= clamp(p.xyz, -1.2,1.2);
    return length(p.xyz)/p.w;
  }
