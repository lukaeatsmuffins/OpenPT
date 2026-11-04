// fractal_de9 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de9.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// highly varied domain - take a look around
  float de( vec3 p ){
    vec3 CSize = vec3(1., 1.7, 1.);
    p = p.xzy;
    float scale = 1.1;
    for( int i=0; i < 8;i++ ){
      p = 2.0*clamp(p, -CSize, CSize) - p;
      float r2 = dot(p,p);
      float k = max((2.)/(r2), .5);
      p *= k; scale *= k;
    }
    float l = length(p.xy);
    float rxy = l - 1.0;
    float n = l * p.z;
    rxy = max(rxy, (n) / 8.);
    return (rxy) / abs(scale);
  }
