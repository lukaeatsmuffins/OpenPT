// fractal_de133 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de133.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,R,S;
    vec3 q=p; R=2.;
    for(int j=0;j++<9;)
      p-=clamp(p,-1.,1.)*2.,
      S=9.*clamp(.7/min(dot(p,p),3.),0.,1.),
      p=p*S+q,
      R=R*abs(S)+1.,
      p=p.yzx;
    return length(p)/R;
  }
