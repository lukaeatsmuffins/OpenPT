// fractal_de31 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de31.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    p.x-=4.;
    p=mod(p,8.)-4.;
    for(int j=0;j<3;j++){
      p.xy=abs(p.xy)-.3;
      p.yz=abs(p.yz)+.7,
      p.xz=abs(p.xz)-.2;
    }
    return length(cross(p,vec3(.5)))-.1;
  }
