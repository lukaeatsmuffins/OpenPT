#ifndef RENDERER_H
#define RENDERER_H

#include <cstdint>
#include <memory>


namespace openpt {
  class App;
  class Renderer {
  public:
    Renderer(App& app) : m_VAO(0), m_VBO(0), m_program(0), m_app(app) {}

    Renderer(const Renderer&) = delete;
    Renderer& operator=(const Renderer&) = delete;

    ~Renderer();

    // displays the rendered image on a rectangle.
    auto display_render() const noexcept -> void;

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
    uint32_t m_FBO;
    uint32_t m_texture;
    uint32_t m_program;
    uint32_t m_compute_program;
    App& m_app;
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
    static constexpr char m_compute_shdr[] = R"(
      #version 460 core
      layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
      layout(rgba32f, binding = 0) uniform image2D screen;

      void main()
      {
          vec4 pixel = vec4(0.075, 0.133, 0.173, 1.0);
          ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);

          ivec2 dims = imageSize(screen);
          float x = -(float(pixel_coords.x * 2 - dims.x) / dims.x); // transforms to [-1.0, 1.0]
          x *= float(dims.x) / float(dims.y);
          float y = -(float(pixel_coords.y * 2 - dims.y) / dims.y); // transforms to [-1.0, 1.0]

          float fov = radians(90.0);
          vec3 cam_o = vec3(0.0, 0.0, -tan(fov / 2.0));
          vec3 ray_o = vec3(x, y, 0.0);
          vec3 ray_d = normalize(ray_o - cam_o);

          vec3 sphere_c = vec3(0.0, 0.0, -5.0);
          float sphere_r = 2.0;

          vec3 o_c = ray_o - sphere_c;
          float b = dot(ray_d, o_c);
          float c = dot(o_c, o_c) - sphere_r * sphere_r;
          float intersectionState = b * b - c;
          vec3 intersection = ray_o + ray_d * (-b - sqrt(b * b - c));

          if (intersectionState >= 0.0)
          {
              pixel = vec4((normalize(intersection - sphere_c) + 1.0) / 2.0, 1.0);
          }

          imageStore(screen, pixel_coords, pixel);
      }
      )";
  };

} // openpt

#endif // !RENDERER_H

