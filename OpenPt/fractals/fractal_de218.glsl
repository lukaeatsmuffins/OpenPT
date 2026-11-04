// fractal_de218 - by butadiene
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de218.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot fractal_de218_rot
#define cube fractal_de218_cube
#define tet fractal_de218_tet

float pi = acos(-1.);
mat2 rot(float r){
  vec2 s = vec2(cos(r),sin(r));
  return mat2(s.x,s.y,-s.y,s.x);
}
float cube(vec3 p,vec3 s){
  vec3 q = abs(p);
  vec3 m = max(s-q,0.);
  return length(max(q-s,0.))-min(min(m.x,m.y),m.z);
}
float tet(vec3 p,vec3 offset,float scale){
  vec4 z = vec4(p,1.);
  for(int i = 0;i<12;i++){
    if(z.x+z.y<0.0)z.xy = -z.yx;
    if(z.x+z.z<0.0)z.xz = -z.zx;
    if(z.z+z.y<0.0)z.zy = -z.yz;
    z *= scale;
    z.xyz += offset*(1.0-scale);
  }
  return (cube(z.xyz,vec3(1.5)))/z.w;
}
float de(vec3 p){
  p.xy *= rot(pi);

  float np = 2.*pi/24.;
  float r = atan(p.x,p.z)-0.5*np;
  r = mod(r,np)-0.5*np;
  p.xz = length(p.xz)*vec2(cos(r),sin(r));

  p.x -= 5.1;
  p.xy *= rot(0.3);
  p.xz *= rot(0.25*pi);

  p.yz *= rot(pi*0.5);
  float s =1.;
  p.z = abs(p.z)-3.;
  p = abs(p)-s*8.;
  p = abs(p)-s*4.;
  p = abs(p)-s*2.;
  p = abs(p)-s*1.;
  vec3 col = vec3(0.082,0.647,0.894);
  return tet(p,vec3(1),1.8);
}
