#ifndef RENDERER_H
#define RENDERER_H

#include <cstdint>
#include <memory>


namespace openpt {
  class App;
  class Renderer {
  public:
    Renderer(uint32_t window_width, uint32_t window_height) :
      m_VAO(0),
      m_VBO(0),
      m_program(0),
      m_window_width(window_width),
      m_window_height(window_height) {}

    Renderer(const Renderer&) = delete;
    Renderer& operator=(const Renderer&) = delete;

    ~Renderer();

    // displays the rendered image on a rectangle.
    auto display_render() const noexcept -> void;

    auto update_window(uint32_t window_width, uint32_t window_height) noexcept -> void;

    auto setup() -> void;

  private:
    auto setup_display_shader() -> void;
    auto setup_display_buffers() -> void;
    auto setup_compute_shader() -> void;
    auto check_shader_creation(uint32_t shdr) const -> void;
    auto check_program_creation(uint32_t program) const -> void;

  private:
    uint32_t m_VAO;
    uint32_t m_VBO;
    uint32_t m_texture;
    uint32_t m_program;
    uint32_t m_compute_program;
    uint32_t m_window_width;
    uint32_t m_window_height;
    static constexpr float m_display_vertices[] = {
       1.0f,  1.0f, 0.0f,  // top right
       1.0f, -1.0f, 0.0f,  // bottom right
      -1.0f,  1.0f, 0.0f,  // top left 
       1.0f, -1.0f, 0.0f,  // bottom right
      -1.0f, -1.0f, 0.0f,  // bottom left
      -1.0f,  1.0f, 0.0f   // top left
    };
    
    static constexpr char m_display_vshdr[] =
      R"(
      #version 460 core
      layout (location = 0) in vec3 aPos;

      out vec2 v_uv;

      void main() {
        gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
        v_uv = (aPos.xy + 1) / 2;
      }
      )";
    static constexpr char m_display_fshdr[] =
      R"(
      #version 460 core
      layout (binding = 0) uniform sampler2D tex;

      in vec2 v_uv;
      out vec4 FragColor;

      void main() {
        FragColor = texture(tex, v_uv);
      }
      )";
    static constexpr char m_comp_shdr_path[] = SHADER_DIR "compute.glsl";
  };

} // openpt

#endif // !RENDERER_H

