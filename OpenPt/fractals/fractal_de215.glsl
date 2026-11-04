// fractal_de215 - by unknown
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de215.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p0){
    vec4 p = vec4(p0, 1.);

    p.xyz=abs(p.xyz);
    if(p.x < p.z)p.xz = p.zx;
    if(p.z < p.y)p.zy = p.yz;
    if(p.y < p.x)p.yx = p.xy;
    for(int i = 0; i < 8; i++){
      if(p.x < p.z)p.xz = p.zx;
      if(p.z < p.y)p.zy = p.yz;
      if(p.y > p.x)p.yx = p.xy;
      p.xyz = abs(p.xyz);
      p*=(1.8/clamp(dot(p.xyz,p.xyz),.0,1.));
      p.xyz-=vec3(3.6,1.9,0.5);
    }
    float m = 1.5;
    p.xyz-=clamp(p.xyz,-m,m);
    return length(p.xyz)/p.w;
  }
