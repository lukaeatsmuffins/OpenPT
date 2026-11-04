// fractal_de134 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de134.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){
    float i,g,e,R=1.,S;
    vec3 q=p;
    for(int j=0;j++<9;)
      p-=clamp(p,-1.,1.)*2.,
      S=6.*clamp(.2/min(dot(p,p),7.),0.,1.),
      p=p*S+q*.7,  R=R*abs(S)+.7;
    return length(p)/R;
  }
