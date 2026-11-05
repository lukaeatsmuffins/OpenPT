#include <shader.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <stdexcept>
#include <sstream>
#include <fstream>
#include <format>
#include <vector>

namespace openpt {
  namespace gl {
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
        glDeleteShader(shdr);
        throw std::runtime_error(std::format(
          "SHADER: Shader compilation failed\n{}\n", infolog));
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
          "SHADER: Shader program linking failed\n{}\n", infolog));
      }
    }

    auto create_compute_shader(const char* path) -> uint32_t {
        return create_compute_program({ read_shader(path) });
    }

    auto create_compute_program(std::initializer_list<std::string_view> sources) -> std::uint32_t {
      std::vector<const char*> ptrs;
      std::vector<GLint> lengths;
      for (const auto s : sources) {
        ptrs.push_back(s.data());
        lengths.push_back(static_cast<GLint>(s.size()));
      }

      const GLuint shader = glCreateShader(GL_COMPUTE_SHADER);
      glShaderSource(shader, static_cast<GLsizei>(ptrs.size()), ptrs.data(), lengths.data());
      glCompileShader(shader);
      check_shader_creation(shader);

      const GLuint program = glCreateProgram();
      glAttachShader(program, shader);
      glLinkProgram(program);
      glDeleteShader(shader);
      try {
        check_program_creation(program);
      } catch (...) {
        glDeleteProgram(program);
        throw;
      }
      return program;
    }

    auto create_texture(const TextureParams& params) noexcept -> uint32_t {
      uint32_t tex{};
      glCreateTextures(GL_TEXTURE_2D, 1, &tex);
      glTextureStorage2D(tex, params.levels, params.format, params.width, params.height);
      glTextureParameteri(tex, GL_TEXTURE_MIN_FILTER, params.min_filter);
      glTextureParameteri(tex, GL_TEXTURE_MAG_FILTER, params.mag_filter);
      glTextureParameteri(tex, GL_TEXTURE_WRAP_S, params.wrap_s);
      glTextureParameteri(tex, GL_TEXTURE_WRAP_T, params.wrap_t);
      return tex;
    }

    auto create_sampler(const SamplerParams& params) noexcept -> uint32_t {
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
