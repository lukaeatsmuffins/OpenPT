#include <shader.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

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

    auto check_shader_creation(uint32_t shdr) -> void {
      constexpr size_t infolog_size = 512;
      char infolog[infolog_size];
      int success{ 0 };

      glGetShaderiv(shdr, GL_COMPILE_STATUS, &success);
      if (!success) {
        glGetShaderInfoLog(shdr, infolog_size, nullptr, infolog);
        throw std::runtime_error(std::format(
          "RENDERER: Shader compilation failed\n{}\n", infolog));
      }
    }

    auto check_program_creation(uint32_t program) -> void {
      constexpr size_t infolog_size = 512;
      char infolog[infolog_size];
      int success{ 0 };

      glGetProgramiv(program, GL_LINK_STATUS, &success);
      if (!success) {
        glGetProgramInfoLog(program, infolog_size, nullptr, infolog);
        throw std::runtime_error(std::format(
          "RENDERER: Shader program linking failed\n{}\n", infolog));
      }
    }

    auto create_compute_shader(const char* path) -> uint32_t {
      auto shdr = glCreateShader(GL_COMPUTE_SHADER);
      std::string src_str = shader::read_shader(path);
      const char* src = src_str.c_str();
      glShaderSource(shdr, 1, &src, NULL);
      glCompileShader(shdr);
      shader::check_shader_creation(shdr);

      auto program = glCreateProgram();
      glAttachShader(program, shdr);
      glLinkProgram(program);
      shader::check_program_creation(program);

      glDeleteShader(shdr);

      return program;
    }

    auto create_texture(const TextureParams& params) -> uint32_t {
      uint32_t tex{};
      glCreateTextures(GL_TEXTURE_2D, 1, &tex);
      glTextureStorage2D(tex, params.levels, params.format, params.width, params.height);
      glTextureParameteri(tex, GL_TEXTURE_MIN_FILTER, params.min_filter);
      glTextureParameteri(tex, GL_TEXTURE_MAG_FILTER, params.mag_filter);
      glTextureParameteri(tex, GL_TEXTURE_WRAP_S, params.wrap_s);
      glTextureParameteri(tex, GL_TEXTURE_WRAP_T, params.wrap_t);
      return tex;
    }

    auto create_sampler(const SamplerParams& params) -> uint32_t {
      uint32_t sampler{};
      glCreateSamplers(1, &sampler);
      glSamplerParameteri(sampler, GL_TEXTURE_MIN_FILTER, params.min_filter);
      glSamplerParameteri(sampler, GL_TEXTURE_MAG_FILTER, params.mag_filter);
      glSamplerParameteri(sampler, GL_TEXTURE_WRAP_S, params.wrap_s);
      glSamplerParameteri(sampler, GL_TEXTURE_WRAP_T, params.wrap_t);
      return sampler;
    }
  } // shader
} // openpt
