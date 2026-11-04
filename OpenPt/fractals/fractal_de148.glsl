// fractal_de148 - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de148.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D

float de(vec3 p){
    float i,j,e,g,h,s;
    p.y-=p.z*.5;
    for(j=s=h=.01;j++<9.;s+=s)
      p.xz*=rotate2D(2.),
      h+=abs(sin(p.x*s)*sin(p.z*s))/s;
    return max(0.,p.y+h);
  }
