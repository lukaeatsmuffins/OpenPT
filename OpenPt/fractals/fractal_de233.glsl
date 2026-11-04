// fractal_de233 - by kamoshika
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de233.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define map fractal_de233_map

#define D(p) abs(dot(sin(p), cos(p.yzx)))
  float map(vec3 p) {
    float d = length(p) - .8;
    p *= 10.;
    d = max(d, (D(p) - .03) / 10.);
    p *= 10.;
    d = max(d, (D(p) - .3) / 100.);
    return d;
  }
