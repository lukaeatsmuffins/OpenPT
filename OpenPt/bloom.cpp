#include <bloom.h>
#include <shader.h>
 
#include <glad/glad.h>
#include <imgui.h>

#include <cmath>
#include <stdexcept>

namespace openpt {
 
  Bloom::Bloom(std::uint32_t width, std::uint32_t height) :
    m_width(width),
    m_height(height) {}
 
  Bloom::~Bloom() {
    destroy_chain();
    glDeleteSamplers(1, &m_sampler);
    glDeleteProgram(m_downsample_program);
    glDeleteProgram(m_upsample_program);
  }
 
  auto Bloom::setup() -> void {
    m_sampler = gl::create_sampler({
        .min_filter = GL_LINEAR_MIPMAP_NEAREST,
        .mag_filter = GL_LINEAR,
        .wrap_s = GL_CLAMP_TO_EDGE,
        .wrap_t = GL_CLAMP_TO_EDGE
      });

    create_chain();

    m_downsample_program = gl::create_compute_shader(m_dwnsmpl_shdr_path);
    m_upsample_program = gl::create_compute_shader(m_upsmpl_shdr_path);
  }
 
  auto Bloom::resize(std::uint32_t width, std::uint32_t height) noexcept -> void {
    m_width = width;
    m_height = height;

    if (width < min_dim_size || height < min_dim_size) {
      return;
    }

    destroy_chain();
    create_chain();
  }
 
  auto Bloom::apply(std::uint32_t source) noexcept -> void {
    if (m_width < min_dim_size || m_height < min_dim_size) {
      return;
    }

    downsample_pass(source);
    upsample_pass();
  }
 
  auto Bloom::output_texture() const noexcept -> std::uint32_t {
    return m_chain; // level 0 holds the final result
  }
 
  auto Bloom::strength() const noexcept -> float {
    return m_settings.strength;
  }
 
  auto Bloom::draw_ui() -> bool {

    if (ImGui::CollapsingHeader("Bloom", ImGuiTreeNodeFlags_DefaultOpen)) {
      ImGui::SliderFloat("Strength", &m_settings.strength, 0.01f, 0.1f, "%.2f");
      ImGui::SliderFloat("Filter Radius", &m_settings.filter_radius, 0.001f, 0.01f, "%.3f");
      ImGui::SliderInt("Levels", &m_settings.levels, 1, 6);
    }

    // Bloom doesn't need to reset the samples as it is PostFX.
    return false;
  }

  auto Bloom::create_chain() -> void {
    auto smaller_dim_size = std::min(m_width, m_height);

    if (smaller_dim_size < min_dim_size) {
      throw std::runtime_error("BLOOM: Image is too small to create a mipmap chain.");
    }

    uint32_t levels_until_0px = static_cast<std::uint32_t>(std::floor(std::log2(smaller_dim_size)) - 1);

    assert(m_settings.levels > 0);
    m_level_count = std::min(static_cast<std::uint32_t>(m_settings.levels), levels_until_0px);

    assert(m_level_count > 0);
    m_chain = gl::create_texture({
        .levels = m_level_count,
        .format = GL_RGBA16F,
        .width = m_width / 2,
        .height = m_height / 2,
        .min_filter = GL_LINEAR_MIPMAP_NEAREST,
        .mag_filter = GL_LINEAR,
        .wrap_s = GL_CLAMP_TO_EDGE,
        .wrap_t = GL_CLAMP_TO_EDGE
      });
  }
 
  auto Bloom::destroy_chain() noexcept -> void {
    glDeleteTextures(1, &m_chain);
    m_chain = 0;
  }
 
  auto Bloom::downsample_pass(std::uint32_t source) noexcept -> void {
    // Use the downsample program; bind m_sampler to unit 0.
    // Pass 0: read `source` (level 0)    -> write chain level 0, with the Karis average (uniform flag).
    // Pass i: read chain level i - 1     -> write chain level i.
    // Each pass: bind the read texture to unit 0, set the source-level uniform,
    // glBindImageTexture(0, m_chain, i, ..., GL_WRITE_ONLY, GL_RGBA16F),
    // dispatch over the *destination* level's size (rounded up to 8x8 groups),
    // then glMemoryBarrier(GL_TEXTURE_FETCH_BARRIER_BIT) so the next pass can sample it.
  }
 
  auto Bloom::upsample_pass() noexcept -> void {
    // Use the upsample program; set the filter radius uniform.
    // From the smallest level up: read chain level i + 1 (sampled, tent filter)
    // and add it into level i: glBindImageTexture(..., level i, GL_READ_WRITE, ...),
    // imageLoad + imageStore in the shader.
    // Dispatch over level i's size; barrier with
    // GL_TEXTURE_FETCH_BARRIER_BIT | GL_SHADER_IMAGE_ACCESS_BARRIER_BIT between passes.
  }
 
} // openpt
 
