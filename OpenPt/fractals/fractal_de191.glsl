// fractal_de191 - by Kali
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de191.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    p.x = abs(p.x) - 3.3;
    p.z = mod(p.z + 2.0, 4.0) -  2.0;
    vec4 q = vec4(p, 1);
    q.xyz -= 1.0;
    q.xyz = q.zxy;
    for(int i = 0; i < 6; i++) {
      q.xyz = abs(q.xyz + 1.0) - 1.0;
      q /= clamp(dot(q.xyz, q.xyz), 0.25, 1.0);
      q *= 1.1;
      float s = sin(-0.35);
      float c = cos(-0.35);
      q.xy = mat2(c,s,-s,c)*q.xy;
    }
    return (length(q.xyz) - 1.5)/q.w;
  }
