#include <renderer.h>
#include <app.h>
#include <shader.h>

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
  }

  auto Renderer::setup() -> void {
      setup_display_buffers();
      setup_display_shader();
      setup_compute_shader();
  }

  auto Renderer::create_texture() noexcept -> void {
    glCreateTextures(GL_TEXTURE_2D, 1, &m_texture);
    glTextureStorage2D(m_texture, 1, GL_RGBA32F, m_window_width, m_window_height);
    glTextureParameteri(m_texture, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTextureParameteri(m_texture, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    constexpr float black[] = { 0.0f, 0.0f, 0.0f, 1.0f };
    glClearTexImage(m_texture, 0, GL_RGBA, GL_FLOAT, black);
  }

  auto Renderer::update_window (uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_window_width = window_width;
    m_window_height = window_height;

    // if window is minimized do not recreate a new texture.
    if (window_width * window_height == 0) {
      return;
    }

    glDeleteTextures(1, &m_texture);
    create_texture();
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

    create_texture();
  }

  auto Renderer::display_render() const noexcept -> void {

    // nothing to render to, exit.
    if (m_window_height * m_window_width == 0) {
      return;
    }

    glClear(GL_COLOR_BUFFER_BIT);

    glBindImageTexture(0, m_texture, 0, GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA32F);
    glUseProgram(m_compute_program);
    glDispatchCompute(std::ceil(m_window_width / 8.0f), std::ceil(m_window_height / 8.0f), 1);
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
    std::string src_str = shader::read_shader(m_comp_shdr_path);
    const char* src = src_str.c_str();
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

  auto Renderer::get_window_size() const noexcept -> glm::vec2 {
    return glm::vec2(m_window_width, m_window_height);
  }

} //openpt