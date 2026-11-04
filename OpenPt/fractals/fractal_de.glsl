// fractal_de - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p0 ){
    vec4 p = vec4(p0, 1.);
    for(int i = 0; i < 8; i++){
      p.xyz = mod(p.xyz-1.,2.)-1.;
      p*=1.4/dot(p.xyz,p.xyz);
    }
    return (length(p.xz/p.w)*0.25);
  }
