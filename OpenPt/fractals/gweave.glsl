// gweave - by gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/gweave.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de ( vec3 p ) {
  float s=2., e, g, l;
  p=abs(mod(p-1.,2.)-1.)-1.;
  for(int j=0;j<8;j++)
    p=1.-abs(p-1.),
    p=p*(l=-1./dot(p,p))-vec3(.1,.3,.1),
    s*=abs(l);
    g+=e=length(p.xz)/s;
  return e;
}
