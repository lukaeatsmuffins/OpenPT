// schwarz - by Schwarz P
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/schwarz.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): time

// Prefix this entry's own globals so they can't clash with the host shader.
#define sdBox schwarz_sdBox

float sdBox(vec3 p, vec3 s) {
    p = abs(p)-s;
  return length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
}
float de(vec3 p) {
    float t = time;
    float box = sdBox(p, vec3(1));
    float scale = 5.5;
    float surf = cos(p.x * scale) + cos(p.y * scale) + cos(p.z * scale) + 2. * sin(t);
    surf = abs(surf) - 0.01;
    surf *= 0.1;
    return max(box, surf);
}
