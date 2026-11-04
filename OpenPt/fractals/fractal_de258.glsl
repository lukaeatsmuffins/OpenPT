// fractal_de258 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de258.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define deee fractal_de258_deee

#define R(p,a,r)mix(a*dot(p,a),p,cos(r))+sin(r)*cross(p,a)
  #define H(h)cos((h)*6.3+vec3(0,23,21))*.5+.5
  float deee(vec3 p){
    float i=0.,g=0.,e,s,a;
    p=R(p,vec3(1),1.2);
    p=mod(p,2.)-1.;
    p.xy=vec2(dot(p.xy,p.xy),length(p.xy)-1.); // interesting
    s=3.;
    for(int i=0;i++<5;){
        p=vec3(10,2,1)-abs(p-vec3(10,5,1));
        s*=e=12./clamp(dot(p,p),.2,8.);
        p=abs(p)*e;
    }
    return min(length(p.xz),p.y)/s+.001;
  }
