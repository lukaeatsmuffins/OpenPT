#ifndef RENDERER_H
#define RENDERER_H

#include <bloom.h>

#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <cstdint>
#include <memory>
#include <filesystem>


namespace openpt {
  class App;
  class Renderer {
  public:
    struct alignas(16) RenderSettings {
      alignas(16) glm::vec4 glow_color; // rgb used, w unused
      float glow_start;
      float glow_end;
      float glow_intensity;
      float sky_intensity;
      float max_distance;
      int max_bounces;
      int max_steps;
      float epsilon;
      float bulb_power;
      int bulb_iterations;
      float bulb_bailout;
      float headlight_intensity;
    };


    Renderer(uint32_t window_width, uint32_t window_height) :
      m_VAO(0),
      m_VBO(0),
      m_program(0),
      m_compute_program(0),
      m_window_width(window_width),
      m_window_height(window_height),
      m_frame_count(0),
      m_sample_count(0),
      m_settings_ubo(0),
      m_exposure(1.0f),
      m_bloom(window_width, window_height),
      m_sky_texture(0) {
      static_assert(offsetof(RenderSettings, glow_start) == 16);
      static_assert(offsetof(RenderSettings, max_bounces) == 36);
      static_assert(offsetof(RenderSettings, bulb_iterations) == 52);
      static_assert(offsetof(RenderSettings, headlight_intensity) == 60);
      static_assert(sizeof(RenderSettings) == 64);
      m_settings = RenderSettings{
        .glow_color     = { 1.0f, 0.55f, 0.2f, 0.0f },
        .glow_start     = 0.55f,
        .glow_end       = 0.80f,
        .glow_intensity = 8.0f,
        .sky_intensity  = 1.0f,
        .max_distance   = 100.0f,
        .max_bounces    = 8,
        .max_steps      = 500,
        .epsilon        = 0.001f,
        .bulb_power     = 8.0f,
        .bulb_iterations = 10,
        .bulb_bailout   = 2.0f,
      };
    }

    Renderer(const Renderer&) = delete;
    Renderer& operator=(const Renderer&) = delete;

    ~Renderer();

    // displays the rendered image on a rectangle.
    auto display_render() -> void;

    auto update_window(uint32_t window_width, uint32_t window_height) noexcept -> void;

    auto get_window_size() const noexcept -> glm::vec2;

    auto setup() -> void;
    
    auto draw_ui() -> bool;

    auto reset_sample_counter() noexcept -> void;

    auto read_screen() const -> std::vector <uint8_t>;

    auto get_dims() const noexcept -> std::pair<uint32_t, uint32_t>;

  private:
    auto setup_display_shader() -> void;
    auto setup_display_buffers() -> void;
    auto setup_settings() -> void;
    auto create_texture() noexcept -> void;
    auto setup_skybox() -> void;
    auto update_counters() -> void;
    auto setup_postfx() -> void;
    auto update_postfx() noexcept -> void;
    auto scan_fractals() -> void;
    auto load_fractal(const std::string& name) -> bool;

  private:
    uint32_t m_VAO;
    uint32_t m_VBO;
    uint32_t m_texture{};
    uint32_t m_program;
    uint32_t m_compute_program;
    uint32_t m_window_width;
    uint32_t m_window_height;
    uint32_t m_frame_count;
    uint32_t m_sample_count;
    uint32_t m_settings_ubo;
    float m_exposure;
    RenderSettings m_settings;
    Bloom m_bloom;
    uint32_t m_sky_texture;

    std::filesystem::path m_fractal_dir{ SHADER_DIR "fractals" };
    std::filesystem::path m_skybox_path{ SHADER_DIR "skybox.hdr" };
    std::vector<std::string> m_fractal_names;
    int m_fractal_index{ 0 };

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
      layout (binding = 0) uniform sampler2D scene;
      layout (binding = 1) uniform sampler2D bloom;

      layout (location = 0) uniform float exposure;
      layout (location = 1) uniform float bloomStrength;

      in vec2 v_uv;
      out vec4 FragColor;

      vec3 aces(vec3 x) {
        const float a = 2.51, b = 0.03, c = 2.43, d = 0.59, e = 0.14;
        return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
      }

      void main() {
        vec3 s = texture(scene, v_uv).rgb;
        vec3 b = textureLod(bloom, v_uv, 0.0).rgb;
        vec3 hdr = mix(s, b, bloomStrength) * exposure;
        FragColor = vec4(pow(aces(hdr), vec3(1.0 / 2.2)), 1.0);
      }
      )";
    static constexpr char m_comp_shdr_path[] = SHADER_DIR "compute.glsl";
    static constexpr char m_common_path[] = SHADER_DIR "dec_common.glsl";
  };

} // openpt

#endif // !RENDERER_H

