// fractal_de48 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de48.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de( vec3 p ){
    p.z-=-1.;
    #define fold(p,v)p-2.*min(0.,dot(p,v))*v;
    float s=3., l=0.;
    for(int i = 0;++i<15;){
      p.xy=fold(p.xy,normalize(vec2(1,-1.3)));
      p.y=-abs(p.y);
      p.y+=.5;
      p.xz=abs(p.xz);
      p.yz=fold(p.yz,normalize(vec2(8,-1)));
      p.x-=.5;
      p.yz=fold(p.yz,normalize(vec2(1,-2)));
      p-=vec3(1.8,.4,.1);
      l = 2.6/dot(p,p);    p*=l;
      p+=vec3(1.8,.7,.2);  s*=l;
    }
    return length(p.xy)/s;
  }
