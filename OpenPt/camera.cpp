#include <camera.h>

namespace openpt {
  auto Camera::update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_aspect_ratio = static_cast<double>(window_width) / static_cast<double>(window_height);
  }
} // openpt