#include <glad/glad.h>
#include <glfw/glfw3.h>

#include <stdexcept>
#include <format>

#include <renderer.h>

namespace openpt {
  auto Renderer::setup() -> void {
      setup_display_buffers();
      setup_display_shader();
  }

  auto Renderer::setup_display_buffers() noexcept -> void {
    glCreateBuffers(1, &m_VBO);
    glNamedBufferData(m_VBO, sizeof(m_display_vertices), m_display_vertices, GL_STATIC_DRAW);

    glCreateVertexArrays(1, &m_VAO);

    constexpr uint32_t slot = 0;
    constexpr uint32_t attrib = 0;
    glVertexArrayVertexBuffer(m_VAO, slot, m_VBO, 0 /*offset*/, 3 * sizeof(float) /*stride*/);
    glVertexArrayAttribFormat(m_VAO, attrib, 3, GL_FLOAT, GL_FALSE, 0 /*relative offset*/);
    glVertexArrayAttribBinding(m_VAO, attrib, slot);

    glEnableVertexArrayAttrib(m_VAO, attrib);
  }

  auto Renderer::display_render() noexcept -> void const {
    glClear(GL_COLOR_BUFFER_BIT);

    glBindVertexArray(m_VAO);
    glUseProgram(m_program);

    glDrawArrays(GL_TRIANGLES, 0, 6);

    glBindVertexArray(0);
  }

  auto Renderer::setup_display_shader() -> void {
    uint32_t vshdr = glCreateShader(GL_VERTEX_SHADER);
    const char* vshdr_src = m_display_vshdr;
    glShaderSource(vshdr, 1, &vshdr_src, NULL);
    glCompileShader(vshdr);
    check_shader_creation(vshdr);

    uint32_t fshdr = glCreateShader(GL_FRAGMENT_SHADER);
    const char* fshdr_src = m_display_fshdr;
    glShaderSource(fshdr, 1, &fshdr_src, NULL);
    glCompileShader(fshdr);
    check_shader_creation(fshdr);

    m_program = glCreateProgram();
    glAttachShader(m_program, vshdr);
    glAttachShader(m_program, fshdr);
    glLinkProgram(m_program);
    check_program_creation();

    glDeleteShader(vshdr);
    glDeleteShader(fshdr);
  }

  auto Renderer::check_shader_creation(uint32_t shdr) const -> void {
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

  auto Renderer::check_program_creation() const -> void {
    constexpr size_t infolog_size = 512;
    char infolog[infolog_size];
    int success{ 0 };

    glGetProgramiv(m_program, GL_LINK_STATUS, &success);
    if (!success) {
      glGetProgramInfoLog(m_program, infolog_size, nullptr, infolog);
      throw std::runtime_error(std::format(
        "RENDERER: Shader program linking failed\n{}\n", infolog));
    }
  }

} //openpt