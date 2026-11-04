// kaleidomecha - by leon
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/kaleidomecha.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define rot kaleidomecha_rot

mat2 rot( float a ) {
    float c = cos( a ),s = sin( a );
    return mat2( c, -s, s, c );
}

float de( vec3 p ) {
    float dist = 100.;

    float t = 196. + time;
    float a = 1.;

    for (float i = 0.; i < 8.; ++i) {
        vec3 e = vec3(.2+.2*sin(i+time),.0,0);
        p.xz = abs(p.xz)-.5*a;
        p.xz *= rot(t*a);
        p.yz *= rot(t*a);
        p = p - clamp(p, -e, e);
        dist = min(dist, length(p)-.01);
        a /= 1.8;
    }

    return dist;
}
