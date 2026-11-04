// fractal_de100 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de100.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,R,S;vec3 q;
    q=p*2.;
    R=7.;
    for(int j=0;j++<9;){
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.);
      S=-9.*clamp(.7/min(dot(p,p),3.),0.,1.);
      p=p*S+q; R=R*abs(S);
    }
    return length(p)/R;
  }
