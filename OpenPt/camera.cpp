#include <camera.h>

namespace openpt {
  auto Camera::update_window(uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_window_width = window_width;
    m_window_height = window_height;
  }

  auto Camera::get_window_size() const noexcept -> glm::vec2 {
    return glm::vec2(m_window_width, m_window_height);
  }
} // openpt