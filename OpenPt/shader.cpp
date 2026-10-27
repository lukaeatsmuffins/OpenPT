#include "shader.h"
#include <stdexcept>
#include <sstream>
#include <fstream>
#include <format>

namespace openpt {
  namespace shader {
    auto read_shader(const char* path) -> std::string {
      std::string code;
      std::ifstream file;
      file.exceptions(std::ifstream::failbit | std::ifstream::badbit);
      try {
          file.open(path);
          std::stringstream ss;
          ss << file.rdbuf();
          file.close();
          code = ss.str();
      }
      catch (std::exception& e) {
        throw std::runtime_error(std::format("SHADER: Unable to load file - {}", e.what()));
      }

      return code;
    }
  } // shader
} // openpt
