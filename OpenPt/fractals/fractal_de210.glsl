// fractal_de210 - by jorge2017a1
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de210.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define maxcomp fractal_de210_maxcomp
#define sdBox fractal_de210_sdBox
#define cylUnion fractal_de210_cylUnion
#define cylIntersection fractal_de210_cylIntersection
#define dsCapsule fractal_de210_dsCapsule
#define DE fractal_de210_DE

float maxcomp(in vec3 p ) { return max(p.x,max(p.y,p.z));}
  float sdBox( vec3 p, vec3 b ){
    vec3  di = abs(p) - b;
    float mc = maxcomp(di);
    return min(mc,length(max(di,0.0)));
  }

  float cylUnion(vec3 p){
    float xy = dot(p.xy,p.xy);
    float xz = dot(p.xz,p.xz);
    float yz = dot(p.yz,p.yz);
    return sqrt(min(xy,min(xz,yz))) - 1.;
  }

  float cylIntersection(vec3 p){
    float xy = dot(p.xy,p.xy);
    float xz = dot(p.xz,p.xz);
    float yz = dot(p.yz,p.yz);
    return sqrt(max(xy,max(xz,yz))) - 1.;
  }

  float dsCapsule(vec3 point_a, vec3 point_b, float r, vec3 point_p)
  {
    vec3 ap = point_p - point_a;
    vec3 ab = point_b - point_a;
    float ratio = dot(ap, ab) / dot(ab , ab);
    ratio = clamp(ratio, 0.0, 1.0);
    vec3 point_c = point_a + ratio * ab;
    return length(point_c - point_p) - r;
  }

  float DE(vec3 p){
    float d = dsCapsule(vec3(-0.0,0.0,0.0), vec3(2.0,1.0,0.1), 1.0, p);
    float s = 1.;
    for(int i = 0;i<5;i++){
      p *= 3.; s*=3.;
      float d2 = cylUnion(p) / s;
      float d3=sdBox(p, vec3(2.0,1.0,2.5));
      d = max(d,-d2);
      p = mod(p+1. , 2.) - 1.;
    }
    return d;
  }
