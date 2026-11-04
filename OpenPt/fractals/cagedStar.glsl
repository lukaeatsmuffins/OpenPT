// cagedStar - by Catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/cagedStar.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define cube cagedStar_cube

float cube(vec3 p){
  p=abs(p)-.1;
  return length(max(p,0.)+min(max(p.x,max(p.y,p.z)),0.));
}
float de(vec3 p){
  float s=2.,r=.7;
  vec3 o=p;
  for(int i=0;i<8;i++){
    p=clamp(p,-1.008,1.008)*2.03-p; //boxfold
    float l=cube(p);
    if(l<.5){p*=2.1;r*=2.1;}else if(l<3.8){p/=l;r/=l;} //ballfold
    p=o+p*s;r=r*abs(s)+1.;
  }
  return .25-length(p)/abs(r);
}
