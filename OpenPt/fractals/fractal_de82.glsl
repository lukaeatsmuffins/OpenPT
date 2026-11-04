// fractal_de82 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de82.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    #define hash(n) fract(sin(n*234.567+123.34))
    float zoom=2.1;
    p*=zoom;
    float seed=dot(floor((p+3.5)/7.)+3.,vec3(123.12,234.56,678.22));
    p-=clamp(p,-8.,8.)*2.;
    float s=3.*zoom;
    p=abs(p);
    vec3  p0 = p*1.6;
    for (float i=0.; i<10.; i++){
      p=1.-abs(abs(p-2.)-1.);
      float g=-8.*clamp(.43*max(1.2/dot(p,p),.8),0.,1.3);
      s*=abs(g); p*=g; p+=p0;
    }
    return length(cross(p,normalize(vec3(1))))/s-.005;
  }
