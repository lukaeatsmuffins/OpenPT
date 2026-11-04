// getwork - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/getwork.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate2D, PI

float de ( vec3 p ) {
  p++;
  float s=3.;
  float e=0.;
  for(int j=0;j++<12;p/=e)
    p=mod(p-1.,2.)-1.,
    p.xz*=rotate2D(PI/4.),
    e=dot(p,p)*.5,
    s/=max(e,0.001);
  return length(p.y)/max(s,0.001)-.7/max(s,0.001);
}
