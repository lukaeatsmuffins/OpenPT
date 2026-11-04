// griddy - by Catzpaw
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/griddy.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float a,e,v,s;
  vec3 q;
  v=3.;

  // parameter originally randomized with twigl fsnoise()
    // a = fsnoise( ceil( p.xz * v + .5 ) ) * v + v;
  a = 10.0; // picked floats work too, but not as cool
  
  e=s;
  for(int j=0;++j<6;v*=a)
    q=abs(mod(p*v,2.)-1.),
    q=max(q,q.zyx),
    e=max(e,(min(q.y,q.z)-.3)/v);
  return e;
}
