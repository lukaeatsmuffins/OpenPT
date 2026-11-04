// fractal_de5 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de5.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 pos ) {
    #define SCALE 2.8
    #define MINRAD2 .25
    #define scale (vec4(SCALE, SCALE, SCALE, abs(SCALE)) / minRad2)
    float minRad2 = clamp(MINRAD2, 1.0e-9, 1.0);
    float absScalem1 = abs(SCALE - 1.0);
    float AbsScale = pow(abs(SCALE), float(1-10));
    vec4 p = vec4(pos,1);
    vec4 p0 = p;
    for (int i = 0; i < 9; i++)
    {
      p.xyz = clamp(p.xyz, -1.0, 1.0) * 2.0 - p.xyz;
      float r2 = dot(p.xyz, p.xyz);
      p *= clamp(max(minRad2/r2, minRad2), 0.0, 1.0);
      p = p*scale + p0;
    }
    return ((length(p.xyz) - absScalem1) / p.w - AbsScale);
  }
