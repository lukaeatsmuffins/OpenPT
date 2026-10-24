#ifndef RENDERER_H
#define RENDERER_H
#include <string>

namespace openpt {
  class Renderer {
  public:
    Renderer() : m_VAO(0), m_VBO(0), m_program(0) {}
    // displays the rendered image on a rectangle.
    auto display_render() noexcept -> void const;

    auto setup() -> void;

  private:
    auto setup_display_shader() -> void;
    auto setup_display_buffers() noexcept -> void;
    auto check_shader_creation(uint32_t shdr) const -> void;
    auto check_program_creation() const -> void;

  private:
    uint32_t m_VAO;
    uint32_t m_VBO;
    uint32_t m_program;
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

      void main()
      {
        gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
      }
      )";
    static constexpr char m_display_fshdr[] =
      R"(
      #version 460 core
      out vec4 FragColor;

      void main()
      {
        FragColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
      }
      )";
  };

} // openpt

#endif // !RENDERER_H

