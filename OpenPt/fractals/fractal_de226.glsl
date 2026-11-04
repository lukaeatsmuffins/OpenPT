// fractal_de226 - by Nameless
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de226.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p0){
    p0 = mod(p0, 2.)-1.;
    vec4 p = vec4(p0, 1.);
    //escape = 0.;
    p=abs(p);
    for(int i = 0; i < 8; i++){
      if(p.x > p.z)p.xz = p.zx;
      if(p.z > p.y)p.zy = p.yz;
      if(p.y > p.x)p.yx = p.xy;
      p*=(1.4/clamp(dot(p.xyz,p.xyz),0.1,1.));
      p.xyz = vec3(2.,4.,2.)-(abs(p.xyz - vec3(2.,4.,1.)));
      //escape += exp(-0.2*dot(p.xyz,p.xyz));
    }
    float m = 1.5;
    p.xyz-=clamp(p.xyz,-m,m);
    return length(p.xyz)/p.w;
  }
