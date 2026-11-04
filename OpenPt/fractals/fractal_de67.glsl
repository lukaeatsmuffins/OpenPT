// fractal_de67 - by WAHa_06x36
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de67.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define periodic fractal_de67_periodic

float periodic(float x,float period,float dutycycle){
    x/=period;
    x=abs(x-floor(x)-0.5)-dutycycle*0.5;
    return x*period;
  }
  float de(vec3 pos){
    vec3 gridpos=pos-floor(pos)-0.5;
    float r=length(pos.xy);
    float a=atan(pos.y,pos.x);
    a+=12.*0.3*sin(floor(r/3.0)+1.0)*sin(floor(pos.z)*13.73);
    return min(max(max(
    periodic(r,3.0,0.2),
    periodic(pos.z,1.0,0.7+0.3*cos(4.))),
    periodic(a*r,3.141592*2.0/6.0*r,0.7+0.3*cos(4.))),0.25);
  }
