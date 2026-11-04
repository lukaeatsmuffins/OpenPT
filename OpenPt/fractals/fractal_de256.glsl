// fractal_de256 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de256.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p0){
    vec4 p = vec4(p0, 1.);
    escape = 0.;
    p=abs(p);
    if(p.x < p.z)p.xz = p.zx;
    if(p.z < p.y)p.zy = p.yz;
    if(p.y < p.x)p.yx = p.xy;
    for(int i = 0; i < 12; i++){
      if(p.x < p.z)p.xz = p.zx;
      if(p.z < p.y)p.zy = p.yz;
      if(p.y < p.x)p.yx = p.xy;
      p = abs(p);
      p*=(1.9/clamp(dot(p.xyz,p.xyz),0.1,1.));
      p.xyz-=vec3(0.2,1.9,0.6);
      escape += exp(-0.2*dot(p.xyz,p.xyz)); 
    }
    float m = 1.2;
    p.xyz-=clamp(p.xyz,-m,m);
    return (length(p.xyz)/p.w);
  }
