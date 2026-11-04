// fractal_de217 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de217.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p0){
    vec4 p = vec4(p0, 1.);
    p.xyz=abs(p.xyz);
    if(p.x < p.z)p.xz = p.zx;
    if(p.z < p.y)p.zy = p.yz;
    if(p.y < p.x)p.yx = p.xy;
    for(int i = 0; i < 8; i++){
      p.xyz = abs(p.xyz);
      uint seed = uint(p.x+p.y+p.z);
      p*=(2./clamp(dot(p.xyz,p.xyz),0.,1.));
      p.xyz-=vec3(.6,.9,2.2);
    }
    float m = 1.0;
    p.xyz-=clamp(p.xyz,-m,m);
  }
