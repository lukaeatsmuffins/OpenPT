#ifndef SHADER_H
#define SHADER_H

#include <string>
#include <cstdint>

namespace openpt {
  namespace gl {
    struct TextureParams {
      uint32_t levels;
      uint32_t format;
      uint32_t width;
      uint32_t height;
      uint32_t min_filter;
      uint32_t mag_filter;
      uint32_t wrap_s;
      uint32_t wrap_t;
    };

    struct SamplerParams {
      uint32_t min_filter;
      uint32_t mag_filter;
      uint32_t wrap_s;
      uint32_t wrap_t;
    };

    auto read_shader(const char* path) -> std::string;
    auto check_shader_creation(uint32_t shdr) -> void;
    auto check_program_creation(uint32_t program) -> void;
    auto create_compute_shader(const char* path) -> uint32_t;
    auto create_texture(const TextureParams& params) -> uint32_t;
    auto create_sampler(const SamplerParams& params) -> uint32_t;
  } // shader
} // openpt

#endif