// fractal_de122 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de122.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e=1.,R,S;
    vec3 q=p*8.; R=8.;
    for(int j=0;j++<6;)
      p=-sign(p)*(abs(abs(abs(p)-2.)-1.)-1.),
      S=-5.*clamp(1.5/dot(p,p),.8,5.),
      p=p*S+q, R*=S;
    return length(p)/R;
  }
