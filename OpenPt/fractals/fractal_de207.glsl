// fractal_de207 - by russ
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de207.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define sdTriPrism fractal_de207_sdTriPrism
#define sdCrossHex fractal_de207_sdCrossHex
#define sdCrossRep fractal_de207_sdCrossRep
#define sdCrossRepScale fractal_de207_sdCrossRepScale

float sdTriPrism( vec3 p, vec2 h ){
    vec3 q = abs(p);
    return max(q.z-h.y,max(q.x*0.866025+p.y*0.5,-p.y)-h.x*0.5);
  }

  float sdCrossHex( in vec3 p ){
    float sdfin=1000.0;
    float sdt1= sdTriPrism( p- vec3(0.0), vec2(1.0) );
    float sdt2= sdTriPrism( -p.xyz- vec3(0.0), vec2(0.5,1.2) );
    float sdt3= sdTriPrism( p.xzy- vec3(0.0), vec2(0.5,1.2) );
    sdfin =max(sdt1, -sdt2);
    sdfin =max(sdfin, -sdt3);
    return sdfin;
  }

  float sdCrossRep(vec3 p) {
  	vec3 q = mod(p + 1.0, 2.0) - 1.0;
  	return sdCrossHex(q);
  }

  float sdCrossRepScale(vec3 p, float s) {
  	return sdCrossRep(p * s) / s;
  }

  float de(vec3 p) {
    float scale = 4.0;
    float dist=sdTriPrism( p-vec3(0.0), vec2(1.0,1.0) );
  	for (int i = 0; i < 5; i++) {
  		dist = max(dist, -sdCrossRepScale(p, scale));
  		scale *= 3.0;
  	}
  	return dist;
  }
