// fractal_de141 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de141.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define F1(a,n)a=abs(a)-n,a=vec2(a.x*.5+a.y,a.x-a.y*.5)
    p=fract(p)-.5;
    for(int j=0;j++<8;)
      F1(p.zy,.0),
      F1(p.xz,.55);
    return .4*length(p.yz)-2e-3;
  }
