// fractal_de142 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de142.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define M(a)mat2(cos(a+vec4(0,2,5,0)))
    #define F1(a)for(int j=0;j<5;j++)p.a=abs(p.a*M(3.));(p.a).y-=3.
    float t = 0.96;
    p.z-=9.;
    p.xz*=M(t);
    F1(xy);
    F1(zy);
    return dot(abs(p),vec3(.3))-.5;
  }
