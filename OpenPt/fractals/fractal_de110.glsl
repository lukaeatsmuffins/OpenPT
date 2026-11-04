// fractal_de110 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de110.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,d=1.,s,h;
    vec3 e,q;
    s=2.;h=.3;
    for(int j=0;j++<8;){
      p=abs(p)-1.; q=p;
      for(int k=0;++k<3;)
        p-=clamp(dot(q,e=vec3(9>>k&1,k>>1&1,k&1)-.5),-h,h)*e*2.;
      p*=1.4;s*=1.4;
    }
    return length(p)/(4.*s);
  }
