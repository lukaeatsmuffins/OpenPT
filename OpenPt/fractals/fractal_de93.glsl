// fractal_de93 - by eiffie
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de93.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    const int iters=5;
    const int iter2=3;
    const float scale=3.48;
    const vec3 offset=vec3(1.9,0.0,2.56);
    const float psni=pow(scale,-float(iters));
    const float psni2=pow(scale,-float(iter2));
    p = abs(mod(p+3., 12.)-6.)-3.;
    vec3 p2;
    for (int n = 0; n < iters; n++) {
      if(n==iter2)p2=p;
      p = abs(p);
      if (p.x < p.y)p.xy = p.yx;
      p.xz = p.zx;
      p = p*scale - offset*(scale-1.0);
      if(p.z<-0.5*offset.z*(scale-1.0))
      p.z+=offset.z*(scale-1.0);
    }
    float d1=(length(p.xy)-1.0)*psni;
    float d2=length(max(abs(p2)-vec3(0.2,5.1,1.3),0.0))*psni2;
    escape=(d1 < d2)?0.:1.;
    return min(d1,d2);
  }
