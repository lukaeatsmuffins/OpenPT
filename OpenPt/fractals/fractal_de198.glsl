// fractal_de198 - by adapted from code by marvelousbilly
// Source:  Distance Estimator Compendium (DEC), https://jbaker.graphics/writings/DEC.html
// Preview: https://jbaker.graphics/writings/images/DEC/fractal_de198.png
// License: CC BY-NC-SA 3.0 (https://creativecommons.org/licenses/by-nc-sa/3.0/)
// NEEDS (not defined here): rotate3D

float de(vec3 p){
    mat3 r = rotate3D(3.14159, vec3(0.,1.,0.));
    float scale= 2.;
    int Iterations = 10;
    int i;
    vec3 C = vec3(1.,5.4,10.+10.*sin(0.5));
    for(i = 0; i < Iterations; i++){
      p = r * (p);
      float x = p.x; float y = p.y; float z = p.z; float x1 = x; float y1 = y;

      x=abs(x);y = abs(y);
      if(x-y<0.){x1=y;y=x;x=x1;}
      if(x-z<0.){x1=z;z=x;x=x1;}
      if(y-z<0.){y1=z;z=y;y=y1;}

      z-=0.5*C.z*(scale-1.)/scale;
      z=-abs(-z);
      z+=0.5*C.z*(scale-1.)/scale;

      p = vec3(x,y,z);
      r = rotate3D(31.4159/4.+5.60,vec3(1.,0.5,0.6));
      p = r * (p);
      x = p.x; y = p.y; z = p.z;

      x=scale*x-C.y*(scale-1.);
      y=scale*y-C.y*(scale-1.);
      z=scale*z;

      p = vec3(x,y,z);
    }
    return (length(p) - 2.) * pow(scale,float(-i));
  }
