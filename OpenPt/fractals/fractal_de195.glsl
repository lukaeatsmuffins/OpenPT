// fractal_de195 - by avi
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de195.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p) {
    const vec3 va = vec3(  0.0,  0.57735,  0.0 );
    const vec3 vb = vec3(  0.0, -1.0,  1.15470 );
    const vec3 vc = vec3(  1.0, -1.0, -0.57735 );
    const vec3 vd = vec3( -1.0, -1.0, -0.57735 );
    float a = 0.0;
    float s = 1.0;
    float r = 1.0;
    float dm;
    vec3 v;
    for(int i=0; i<16; i++) {
      float d, t;
      d = dot(p-va,p-va);              v=va; dm=d; t=0.0;
      d = dot(p-vb,p-vb); if( d < dm ) { v=vb; dm=d; t=1.0; }
      d = dot(p-vc,p-vc); if( d < dm ) { v=vc; dm=d; t=2.0; }
      d = dot(p-vd,p-vd); if( d < dm ) { v=vd; dm=d; t=3.0; }
      p = v + 2.0*(p - v); r*= 2.0;
      a = t + 4.0*a; s*= 4.0;
    }
    return (sqrt(dm)-1.0)/r;
  }
