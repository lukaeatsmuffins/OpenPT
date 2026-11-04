// Shared helpers that some DEC entries call without defining them.
// rotate2D / rotate3D / PI are from the twigl header the DEC site links
// (https://jbaker.graphics/resources/noise.glsl, MIT license); M_PI is the usual constant.

const float PI   = 3.141592653589793;
const float M_PI = 3.141592653589793;

mat2 rotate2D(float r) {
    return mat2(cos(r), sin(r), -sin(r), cos(r));
}

mat3 rotate3D(float angle, vec3 axis) {
    vec3 a = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float r = 1.0 - c;
    return mat3(
        a.x * a.x * r + c,
        a.y * a.x * r + a.z * s,
        a.z * a.x * r - a.y * s,
        a.x * a.y * r - a.z * s,
        a.y * a.y * r + c,
        a.z * a.y * r + a.x * s,
        a.x * a.z * r + a.y * s,
        a.y * a.z * r - a.x * s,
        a.z * a.z * r + c
    );
}

// Many entries are written for twigl/Shadertoy, where `time` is the animation clock.
// Frozen here: an animated scene would break sample accumulation.
const float time = 0.0;
