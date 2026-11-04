// fractal_de135 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de135.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,R,S;
    vec3 q;
    p.z-=3.;
    q=p; R=1.;
    for(int j=0;j++<9;)
      p-=clamp(p,-.9,.9)*2.,
      S=9.*clamp(.1/min(dot(p,p),1.),0.,1.),
      p=p*S+q, R=R*S+1.;
    return .7*length(p)/R;
  }
