// fractal_de132 - by iq
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de132.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define maxcomp fractal_de132_maxcomp
#define sdBox fractal_de132_sdBox

float maxcomp(in vec3 p ){
  	return max(p.x,max(p.y,p.z));
  }

  float sdBox( vec3 p, vec3 b ){
    vec3  di = abs(p) - b;
    float mc = maxcomp(abs(p)-b);
    return min(mc,length(max(di,0.0)));
  }

  float de(vec3 p){
    vec3 w = p; vec3 q = p;
    q.xz = mod( q.xz+1.0, 2.0 ) -1.0;
    float d = sdBox(q,vec3(1.0));
    float s = 1.0;
    for( int m=0; m<7; m++ ){
      float h = float(m)/6.0;
      p =  q.yzx - 0.5*sin( 1.5*p.x + 6.0 + p.y*3.0 + float(m)*5.0 + vec3(1.0,0.0,0.0));
      vec3 a = mod( p*s, 2.0 )-1.0;
      s *= 3.0;
      vec3 r = abs(1.0 - 3.0*abs(a));
      float da = max(r.x,r.y);
      float db = max(r.y,r.z);
      float dc = max(r.z,r.x);
      float c = (min(da,min(db,dc))-1.0)/s;
      d = max( c, d );
    }
    return d*0.5;
  }
