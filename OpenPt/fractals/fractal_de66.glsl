// fractal_de66 - by xem
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de66.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    vec4 o=vec4(p,1);
    vec4 q=o;
    for(float i=0.;i<9.;i++){
      o.xyz=clamp(o.xyz,-1.,1.)*2.-o.xyz;
      o=o*clamp(max(.25/dot(o.xyz,o.xyz),.25),0.,1.)*vec4(11.2)+q;
    }
    return (length(o.xyz)-1.)/o.w-5e-4;
  }
