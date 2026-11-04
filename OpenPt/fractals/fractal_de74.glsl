// fractal_de74 - by lewiz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de74.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sphereFold fractal_de74_sphereFold
#define boxFold fractal_de74_boxFold

void sphereFold(inout vec3 z, inout float dz){
    float r2 = dot(z,z);
    if (r2 < 0.5){
      float temp = 2.0;
      z *= temp;
      dz*= temp;
    }else if (r2 < 1.0){
      float temp = 1.0 / r2;
      z *= temp; dz*= temp;
    }
  }
  void boxFold(inout vec3 z, inout float dz){
    z = clamp(z, -1.0, 1.0) * 2.0 - z;
  }
  float de(vec3 z){
    float scale = 2.0;
    vec3 offset = z;
    float dr = 1.0;
    for (int n = 0; n < 10; n++){
      boxFold(z,dr);
      sphereFold(z,dr);
      z = scale * z + offset;
      dr = dr * abs(scale) + 1.0;
    }
    float r = length(z);
    return r / abs(dr);
  }
