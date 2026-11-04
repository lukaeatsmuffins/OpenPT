// fractal_de144 - by adapted from code by wrighter
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de144.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)

float de(vec3 p){ // has aliasing issues
    vec3 a = sin(p/dot(p,p)*4);
    return 0.95*min(length(a.yx),length(a.yz))-0.52+0.2;
  }
