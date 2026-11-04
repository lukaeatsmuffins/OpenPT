// fractal_de89 - by Ivan Dianov
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de89.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define rot(a) mat2(cos(a),sin(a),-sin(a),cos(a))
    p.z-=.25;
    float j=0.,c=0.,s=1.;
    p.y = fract(p.y)-.5;
    for(;j<10.;j++){
      p=abs(p);
      p-=vec2(.05,.5).xyx;
      p.xz*=rot(1.6);
      p.yx*=rot(.24);
      p*=2.; s*=2.;
    }
    return (length(p)-1.)/s*.5;
  }
