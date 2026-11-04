// fractal_de131 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de131.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): PI

float de(vec3 p){
    float l,s=3.;
    float t = 4.5;
    for(int j=0;j++<5;p.xy=fract(p.xy+p.x)-.5)
      p=vec3(log(l=length(p.xy)),atan(p.y,p.x)/PI*2.,p.z/l+1.),
      s*=.5*l;
    return abs(p.z)*s;
  }
