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
 
  auto Bloom::apply(std::uint32_t source_tex) noexcept -> void {
    if (m_width < min_dim_size || m_height < min_dim_size) {
      return;
    }

    downsample_pass(source_tex);
    upsample_pass();

    glBindSampler(0, 0);
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
      if (ImGui::SliderInt("Levels", &m_settings.levels, 1, 6)) {
        // recreate the chain.
        resize(m_width, m_height);
      }
    }

    // bloom doesn't need to reset the samples as it is PostFX.
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
    glUseProgram(m_downsample_program);
    glBindSampler(0, m_sampler);

    for (std::uint32_t i = 0; i < m_level_count; ++i) {
      const bool first = (i == 0);

      glBindTextureUnit(0, first ? source : m_chain);
      glProgramUniform1i(m_downsample_program, 0, first ? 0 : static_cast<GLint>(i - 1));
      glProgramUniform1i(m_downsample_program, 1, first ? 1 : 0);

      glBindImageTexture(0, m_chain, static_cast<GLint>(i), GL_FALSE, 0, GL_WRITE_ONLY, GL_RGBA16F);

      // one thread per pixel of the destination level (chain level 0 is half the image size).
      const std::uint32_t w = std::max(1u, (m_width / 2) >> i);
      const std::uint32_t h = std::max(1u, (m_height / 2) >> i);
      glDispatchCompute((w + 7) / 8, (h + 7) / 8, 1);

      glMemoryBarrier(GL_TEXTURE_FETCH_BARRIER_BIT);
    }
    glMemoryBarrier(GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
  } 

  auto Bloom::upsample_pass() noexcept -> void {
    glUseProgram(m_upsample_program);
    glBindSampler(0, m_sampler);

    for (std::uint32_t i = m_level_count - 1; i > 0; --i) {

      glBindTextureUnit(0, m_chain);
      glProgramUniform1i(m_upsample_program, 0, static_cast<GLint>(i));
      glProgramUniform1f(m_upsample_program, 1, m_settings.filter_radius);

      glBindImageTexture(0, m_chain, static_cast<GLint>(i-1), GL_FALSE, 0, GL_READ_WRITE, GL_RGBA16F);

      const std::uint32_t w = std::max(1u, (m_width / 2) >> (i-1));
      const std::uint32_t h = std::max(1u, (m_height / 2) >> (i-1));
      glDispatchCompute((w + 7) / 8, (h + 7) / 8, 1);

      glMemoryBarrier(GL_TEXTURE_FETCH_BARRIER_BIT | GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
    }
  }
} // openpt
 
