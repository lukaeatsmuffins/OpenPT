#ifndef SHADER_H
#define SHADER_H

#include <string>

namespace openpt {
  namespace shader {
    auto read_shader(const char* path) -> std::string;
  } // shader
} // openpt

#endif