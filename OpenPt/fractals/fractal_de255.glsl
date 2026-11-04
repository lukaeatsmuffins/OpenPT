// fractal_de255 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de255.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sphere_folds fractal_de255_sphere_folds
#define box_folds fractal_de255_box_folds

void sphere_folds(inout vec3 z, inout float dz) {
    float fixed_radius2 = 1.9;
    float min_radius2 = 0.1;
    float r2 = dot(z, z);
    if(r2 < min_radius2) {
      float temp = (fixed_radius2 / min_radius2);
      z *= temp; dz *= temp;
    }else if(r2 < fixed_radius2) {
      float temp = (fixed_radius2 / r2);
      z *= temp; dz *= temp;
    }
  }
  void box_folds(inout vec3 z, inout float dz) {
    float folding_limit = 1.0;
    z = clamp(z, -folding_limit, folding_limit) * 2.0 - z;
  }
  float de(vec3 z) {
    vec3 offset = z;
    float scale = -2.8;
    float dr = 1.0;
    escape = 0.;
    for(int n = 0; n < 15; ++n) {
      box_folds(z, dr);
      sphere_folds(z, dr);
      z = scale * z + offset;
      dr = dr * abs(scale) + 1.0;
      escape += exp(-0.2*dot(z.xyz,z.xyz));
    }
    float r = length(z);
    return r / abs(dr);
  }
