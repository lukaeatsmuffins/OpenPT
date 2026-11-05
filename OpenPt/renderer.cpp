#include <renderer.h>
#include <app.h>
#include <shader.h>

#include <glad/glad.h>

#include <algorithm>
#include <stdexcept>
#include <format>

namespace openpt {

  Renderer::~Renderer() {
    glDeleteProgram(m_program);
    glDeleteProgram(m_compute_program);
    glDeleteBuffers(1, &m_VBO);
    glDeleteVertexArrays(1, &m_VAO);
    glDeleteTextures(1, &m_texture);
    glDeleteBuffers(1, &m_settings_ubo);
  }

  auto Renderer::setup() -> void {
      setup_display_buffers();
      setup_display_shader();
      setup_settings();
      setup_postfx();
      scan_fractals();
  }

  auto Renderer::draw_ui() -> bool {
    bool changed = false;

    if (ImGui::CollapsingHeader("Rendering", ImGuiTreeNodeFlags_DefaultOpen)) {
      changed |= ImGui::SliderInt("Max bounces", &m_settings.max_bounces, 1, 16);
      changed |= ImGui::SliderInt("Max steps", &m_settings.max_steps, 16, 1000);
      changed |= ImGui::SliderFloat("Surface epsilon", &m_settings.epsilon, 0.00001f, 0.01f, "%.5f",
                                    ImGuiSliderFlags_Logarithmic);
      changed |= ImGui::SliderFloat("Sky intensity", &m_settings.sky_intensity, 0.0f, 5.0f);
      changed |= ImGui::SliderFloat("Headlight", &m_settings.headlight_intensity, 0.0f, 100.0f, "%.2f",
                              ImGuiSliderFlags_Logarithmic);

      // Display-only: applied after accumulation, so no reset needed.
      ImGui::SliderFloat("Exposure", &m_exposure, 0.1f, 10.0f, "%.2f", ImGuiSliderFlags_Logarithmic);

      ImGui::Text("Samples: %u", m_sample_count);
    }

    if (ImGui::CollapsingHeader("Glow", ImGuiTreeNodeFlags_DefaultOpen)) {
      changed |= ImGui::ColorEdit3("Glow color", &m_settings.glow_color.x);
      changed |= ImGui::SliderFloat("Glow start", &m_settings.glow_start, 0.0f, 1.5f);
      changed |= ImGui::SliderFloat("Glow end", &m_settings.glow_end, 0.0f, 1.5f);
      changed |= ImGui::SliderFloat("Glow intensity", &m_settings.glow_intensity, 0.0f, 50.0f, "%.1f",
                                    ImGuiSliderFlags_Logarithmic);

      // smoothstep(start, end, x) is undefined when start >= end.
      m_settings.glow_end = std::max(m_settings.glow_end, m_settings.glow_start + 0.001f);
    }

    if (ImGui::CollapsingHeader("Fractal", ImGuiTreeNodeFlags_DefaultOpen)) {
      changed |= ImGui::SliderFloat("Power", &m_settings.bulb_power, 2.0f, 16.0f, "%.2f");
      changed |= ImGui::SliderInt("Iterations", &m_settings.bulb_iterations, 1, 20);
      if (m_fractal_names.empty()) {
        ImGui::TextUnformatted("No fractals found");
      } else if (ImGui::BeginCombo("Fractal##select",
                                   m_fractal_names[m_fractal_index].c_str(),
                                   ImGuiComboFlags_HeightLarge)) {
        for (int i = 0; i < std::ssize(m_fractal_names); ++i) {
          const bool selected = (i == m_fractal_index);
          if (ImGui::Selectable(m_fractal_names[i].c_str(), selected) && !selected) {
            if (load_fractal(m_fractal_names[i])) {
              m_fractal_index = i;
              changed = true;
            }
          }
          if (selected) {
            ImGui::SetItemDefaultFocus();
          }
        }
        ImGui::EndCombo();
      }

    }

    changed |= m_bloom.draw_ui();

    return changed;
  }

  auto Renderer::create_texture() noexcept -> void {
    m_texture = gl::create_texture({
        .levels = 1,
        .format = GL_RGBA32F,
        .width = m_window_width,
        .height = m_window_height,
        .min_filter = GL_NEAREST,
        .mag_filter = GL_NEAREST,
        .wrap_s = GL_CLAMP_TO_EDGE,
        .wrap_t = GL_CLAMP_TO_EDGE
      });

    constexpr float black[] = { 0.0f, 0.0f, 0.0f, 1.0f };
    glClearTexImage(m_texture, 0, GL_RGBA, GL_FLOAT, black);
  }

  auto Renderer::update_window(uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_window_width = window_width;
    m_window_height = window_height;

    // if window is minimized do not recreate a new texture.
    if (window_width * window_height == 0) {
      return;
    }

    glDeleteTextures(1, &m_texture);
    create_texture();
    update_postfx();
  }

  auto Renderer::update_postfx() noexcept -> void {
    m_bloom.resize(m_window_width, m_window_height);
  }

  auto Renderer::read_screen() const -> std::vector<std::uint8_t> {
    std::vector<std::uint8_t> pixels(std::size_t{ m_window_width } * m_window_height * 3);
    glPixelStorei(GL_PACK_ALIGNMENT, 1); // rows are 3 * width bytes, not padded to 4
    glReadPixels(0, 0, m_window_width, m_window_height, GL_RGB, GL_UNSIGNED_BYTE, pixels.data());
    return pixels;
  }

  auto Renderer::get_dims() const noexcept -> std::pair<uint32_t, uint32_t>{
    return { m_window_width, m_window_height };
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

  auto Renderer::display_render() -> void {

    // nothing to render to, exit.
    if (m_window_height * m_window_width == 0) {
      return;
    }

    update_counters();
    glClear(GL_COLOR_BUFFER_BIT);

    glBindImageTexture(0, m_texture, 0, GL_FALSE, 0, GL_READ_WRITE, GL_RGBA32F);
    glUseProgram(m_compute_program);
    glNamedBufferSubData(m_settings_ubo, 0, sizeof(RenderSettings), &m_settings);
    glProgramUniform1f(m_program, 0, m_exposure);
    glDispatchCompute(std::ceil(m_window_width / 8.0f), std::ceil(m_window_height / 8.0f), 1);
    glMemoryBarrier(GL_ALL_BARRIER_BITS);

    m_bloom.apply(m_texture);

    glProgramUniform1f(m_program, 1, m_bloom.strength());
    glBindVertexArray(m_VAO);
    glUseProgram(m_program);

    glBindTextureUnit(0, m_texture);
    glBindTextureUnit(1, m_bloom.output_texture());

    glDrawArrays(GL_TRIANGLES, 0, 6);
  }

  auto Renderer::setup_display_shader() -> void {
    uint32_t vshdr = glCreateShader(GL_VERTEX_SHADER);
    const char* vshdr_src = m_display_vshdr;
    glShaderSource(vshdr, 1, &vshdr_src, NULL);
    glCompileShader(vshdr);
    gl::check_shader_creation(vshdr);

    uint32_t fshdr = glCreateShader(GL_FRAGMENT_SHADER);
    const char* fshdr_src = m_display_fshdr;
    glShaderSource(fshdr, 1, &fshdr_src, NULL);
    glCompileShader(fshdr);
    gl::check_shader_creation(fshdr);

    m_program = glCreateProgram();
    glAttachShader(m_program, vshdr);
    glAttachShader(m_program, fshdr);
    glLinkProgram(m_program);
    gl::check_program_creation(m_program);

    glDeleteShader(vshdr);
    glDeleteShader(fshdr);
  }

  auto Renderer::setup_settings() -> void {
    glCreateBuffers(1, &m_settings_ubo);
    glNamedBufferStorage(m_settings_ubo, sizeof(RenderSettings), nullptr, GL_DYNAMIC_STORAGE_BIT);
    glBindBufferBase(GL_UNIFORM_BUFFER, 1, m_settings_ubo);
  }

  auto Renderer::setup_postfx() -> void {
    m_bloom.setup();
  }

  auto Renderer::get_window_size() const noexcept -> glm::vec2 {
    return glm::vec2(m_window_width, m_window_height);
  }
  
  auto Renderer::update_counters() -> void {
    glProgramUniform1ui(m_compute_program, 0, m_frame_count++);
    glProgramUniform1ui(m_compute_program, 1, m_sample_count++);
    glfwSetWindowTitle(glfwGetCurrentContext(), std::format("OpenPT - Frame: {} Sample: {}", m_frame_count, m_sample_count).c_str());
  }

  auto Renderer::reset_sample_counter() noexcept -> void {
    m_sample_count = 0;
  }

  auto Renderer::scan_fractals() -> void {
    m_fractal_names.clear();
    for (const auto& entry : std::filesystem::directory_iterator(m_fractal_dir)) {
      if (entry.is_regular_file() && entry.path().extension() == ".glsl") {
        m_fractal_names.push_back(entry.path().stem().string());
      }
    }

    std::ranges::sort(m_fractal_names, {}, [](const std::string& s) { return std::pair{ s.size(), s }; });
    if (m_fractal_names.empty() || !load_fractal(m_fractal_names[m_fractal_index])) {
      throw std::runtime_error("RENDERER: no fractal could be loaded");
    }
  }
  
  auto Renderer::load_fractal(const std::string& name) -> bool {
    try {
      const std::string main_src    = gl::read_shader(m_comp_shdr_path);
      const std::string common_src  = gl::read_shader(m_common_path);
      const std::string fractal_src = gl::read_shader((m_fractal_dir / (name + ".glsl")).string().c_str());

      const GLuint program = gl::create_compute_program({ main_src, common_src, "#line 1\n", fractal_src });

      glDeleteProgram(m_compute_program);
      m_compute_program = program;
      reset_sample_counter();
      return true;
    } catch (const std::exception& e) {
      std::println(stderr, "Fractal '{}' failed: {}", name, e.what());
      return false;
    }
  }
} //openpt