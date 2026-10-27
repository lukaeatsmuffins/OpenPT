#include <renderer.h>
#include <app.h>

#include <glad/glad.h>

#include <stdexcept>
#include <format>

namespace openpt {

  Renderer::~Renderer() {
    glDeleteProgram(m_program);
    glDeleteProgram(m_compute_program);
    glDeleteBuffers(1, &m_VBO);
    glDeleteVertexArrays(1, &m_VAO);
    glDeleteTextures(1, &m_texture);
    glDeleteFramebuffers(1, &m_FBO);
  }

  auto Renderer::setup() -> void {
      setup_display_buffers();
      setup_display_shader();
      setup_compute_shader();
  }

  auto Renderer::setup_display_buffers() -> void {
    // create a data buffer.
    glCreateBuffers(1, &m_VBO);
    glNamedBufferData(m_VBO, sizeof(m_display_vertices), m_display_vertices, GL_STATIC_DRAW);

    // create a vertex array obj.
    constexpr uint32_t slot = 0;
    constexpr uint32_t attrib = 0;

    glCreateVertexArrays(1, &m_VAO);
    glVertexArrayVertexBuffer(m_VAO, slot, m_VBO, 0 /*offset*/, 3 * sizeof(float) /*stride*/);
    glVertexArrayAttribFormat(m_VAO, attrib, 3, GL_FLOAT, GL_FALSE, 0 /*relative offset*/);
    glVertexArrayAttribBinding(m_VAO, attrib, slot);
    glEnableVertexArrayAttrib(m_VAO, attrib);

    // create texture for the framebuffer.
    glCreateTextures(GL_TEXTURE_2D, 1, &m_texture);
    glTextureStorage2D(m_texture, 1, GL_RGBA32F, m_app.window_width(), m_app.window_height());
    glTextureParameteri(m_texture, GL_TEXTURE_MIN_FILTER, GL_NEAREST);   // how sampling filters
    glTextureParameteri(m_texture, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    // create frame buffer that will contain the texture as color attachment.
    glCreateFramebuffers(1, &m_FBO);
    glNamedFramebufferTexture(m_FBO, GL_COLOR_ATTACHMENT0, m_texture, 0 /*level*/);
    if (glCheckNamedFramebufferStatus(m_FBO, GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
      throw std::runtime_error("OPENGL: Unable to create a complete framebuffer");
    }

    constexpr float red[] = { 1.0f, 0.0f, 0.0f, 1.0f };
    glClearTexImage(m_texture, 0, GL_RGBA, GL_FLOAT, red);
  }

  auto Renderer::display_render() const noexcept -> void {

    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glClear(GL_COLOR_BUFFER_BIT);

    glBindImageTexture(0, m_texture, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
    glUseProgram(m_compute_program);
    glDispatchCompute(std::ceil(m_app.window_width() / 8), std::ceil(m_app.window_height() / 8), 1);
    glMemoryBarrier(GL_ALL_BARRIER_BITS);

    glBindVertexArray(m_VAO);
    glUseProgram(m_program);
    glBindTextureUnit(0, m_texture);

    glDrawArrays(GL_TRIANGLES, 0, 6);
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
    check_program_creation(m_program);

    glDeleteShader(vshdr);
    glDeleteShader(fshdr);
  }

  auto Renderer::setup_compute_shader() -> void {
    uint32_t shdr = glCreateShader(GL_COMPUTE_SHADER);
    const char* src = m_compute_shdr;
    glShaderSource(shdr, 1, &src, NULL);
    glCompileShader(shdr);
    check_shader_creation(shdr);

    m_compute_program = glCreateProgram();
    glAttachShader(m_compute_program, shdr);
    glLinkProgram(m_compute_program);
    check_program_creation(m_compute_program);

    glDeleteShader(shdr);

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

  auto Renderer::check_program_creation(uint32_t program) const -> void {
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

} //openpt