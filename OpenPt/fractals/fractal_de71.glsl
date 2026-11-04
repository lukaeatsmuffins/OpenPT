// fractal_de71 - by glkt
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de71.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

// Prefix this entry's own globals so they can't clash with the host shader.
#define smin fractal_de71_smin
#define noise fractal_de71_noise

float smin( float a, float b, float k ){
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return mix( b, a, h ) - k*h*(1.0-h);
  }
  float noise(vec3 p){
    vec3 np = normalize(p);

    float a = 0.1*snoise2D(np.xy*10.);
    float b = 0.1*snoise2D(0.77+np.yz*10.);

    a = mix(a,.5,abs(np.x));
    b = mix(b,.5,abs(np.z));
    return mix(a+b-.4,.5,abs(np.y)/2.);
  }
  float de(vec3 p){
    float d = (-1.*length(p)+3.)+1.5*noise(p);
    d = min(d, (length(p)-1.5)+1.5*noise(p) );
    float m = 1.5; float s = .03;
    d = smin(d, max( abs(p.x)-s, abs(p.y+p.z*.2)-.07 ) , m);
    d = smin(d, max( abs(p.z)-s, abs(p.x+p.y/2.)-.07 ), m );
    d = smin(d, max( abs(p.z-p.y*.4)-s, abs(p.x-p.y*.2)-.07 ), m );
    d = smin(d, max( abs(p.z*.2-p.y)-s, abs(p.x+p.z)-.07 ), m );
    d = smin(d, max( abs(p.z*-.2+p.y)-s, abs(-p.x+p.z)-.07 ), m );
    return d;
  }
