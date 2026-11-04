// fractal_de193 - by Kali
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de193.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 pos){
    vec3 tpos=pos;
    tpos.xz=abs(.5-mod(tpos.xz,1.));
    vec4 p=vec4(tpos,1.);
    float y=max(0.,.35-abs(pos.y-3.35))/.35;
    for (int i=0; i<7; i++) {
      p.xyz = abs(p.xyz)-vec3(-0.02,1.98,-0.02);
      p=p*(2.0+0.*y)/clamp(dot(p.xyz,p.xyz),.4,1.)-vec4(0.5,1.,0.4,0.);
      p.xz*=mat2(-0.416,-0.91,0.91,-0.416);
    }
    return (length(max(abs(p.xyz)-vec3(0.1,5.0,0.1),vec3(0.0)))-0.05)/p.w;
  }
