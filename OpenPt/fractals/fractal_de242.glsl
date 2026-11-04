// fractal_de242 - by gaziya5 aka gaz
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de242.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define lpNorm fractal_de242_lpNorm
#define map fractal_de242_map

#define rot(a)mat2(cos(a),sin(a),-sin(a),cos(a))
  float lpNorm(vec3 p, float n){
  	p = pow(abs(p), vec3(n));
  	return pow(p.x+p.y+p.z, 1.0/max(n,0.001));
  }
  float map(vec3 p){
    vec3 q=p;
  	float s = 2.5;
  	for(int i = 0; i < 10; i++) {
      p=mod(p-1.,2.)-1.;
  	float r2=1.1/max(pow(lpNorm(abs(p),2.+q.y*10.),1.75), 0.001);
    	p*=r2;
    	s*=r2;
      p.xy*=rot(.001);
    }
    return q.y>1.3?length(p)/max(s,0.001):abs(p.y)/max(s,0.001);
  }
