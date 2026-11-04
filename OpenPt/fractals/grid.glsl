// grid - by yonatan
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/grid.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ){
  float v = 2., e = 0.0, g = 0.0;
  p = abs(fract(p)-.5)+.12;
  
  if( p.x>p.y )
    p.xy=p.yx;
  
  if( p.y<p.z )
    p.yz=p.zy;
  
  for(int j=0;j++<16;p=abs(p)/e-.25)
    p.y-=3.5-g*.4,
    v/=e=min(dot(p,p)+.1,.5);
  return g+=e=length(p)/v;
}
