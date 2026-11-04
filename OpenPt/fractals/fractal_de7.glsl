// fractal_de7 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de7.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// highly varied domain - take a look around
  float de( vec3 p ){
    p = p.xzy;
    vec3 cSize = vec3(1., 1., 1.3);
    float scale = 1.;
    for( int i=0; i < 12; i++ ){
      p = 2.0*clamp(p, -cSize, cSize) - p;
      float r2 = dot(p,p+sin(p.z*.3));
      float k = max((2.)/(r2), .027);
      p *= k;  scale *= k;
    }
    float l = length(p.xy);
    float rxy = l - 4.0;
    float n = l * p.z;
    rxy = max(rxy, -(n) / 4.);
    return (rxy) / abs(scale);
  }
