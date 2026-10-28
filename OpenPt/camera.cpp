#include <camera.h>

namespace openpt {
  auto Camera::setup() noexcept -> void {
    glCreateBuffers(1, &m_UBO);
    glNamedBufferStorage(m_UBO, sizeof(CameraData), nullptr, GL_DYNAMIC_STORAGE_BIT);
    glBindBufferBase(GL_UNIFORM_BUFFER, 0, m_UBO);
  }

  auto Camera::update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_aspect_ratio = static_cast<double>(window_width) / static_cast<double>(window_height);
  }

  auto Camera::update_uniforms() noexcept -> void {
    CameraData camera_data{
      glm::vec4(m_vpos, 1.0f),
      glm::vec4(m_u, 0.0f),
      glm::vec4(m_v, 0.0f),
      glm::vec4(m_w, 0.0f),
      m_vfov,
      m_aspect_ratio
    };

    glNamedBufferSubData(m_UBO, 0, sizeof(CameraData), &camera_data);
  }
} // openpt