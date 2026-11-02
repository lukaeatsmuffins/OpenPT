#include <camera.h>

namespace openpt {
  auto Camera::setup() noexcept -> void {
    glCreateBuffers(1, &m_UBO);
    glNamedBufferStorage(m_UBO, sizeof(CameraData), nullptr, GL_DYNAMIC_STORAGE_BIT);
    glBindBufferBase(GL_UNIFORM_BUFFER, 0, m_UBO);
  }

  auto Camera::move_camera(float delta_time, glm::vec3 direction) noexcept -> void {
    constexpr float sensitivity = 0.1f;
    const float camera_speed = sensitivity * delta_time;
    m_vpos += camera_speed * direction.x * m_u ;
    m_vpos += camera_speed * direction.y * m_vup;
    m_vpos += camera_speed * direction.z * (glm::normalize(glm::vec3(m_w.x, 0.0f, m_w.z)));
  }

  auto Camera::rotate_camera(float x_offset, float y_offset) noexcept -> void {
    constexpr float sensitivity = 0.1f;
    m_yaw += x_offset * sensitivity;
    m_pitch += y_offset * sensitivity;

    if (m_pitch > 89.0f) {
      m_pitch =  89.0f;
    }
    if (m_pitch < -89.0f) {
      m_pitch = -89.0f;
    }

    glm::vec3 direction{
      cos(glm::radians(m_pitch)) * cos(glm::radians(m_yaw)),
      sin(glm::radians(m_pitch)),
      cos(glm::radians(m_pitch)) * sin(glm::radians(m_yaw))
    };
    update_direction(glm::normalize(direction));
  }

  auto Camera::update_direction(glm::vec3 direction) noexcept -> void {
    m_direction = direction;
    m_w = glm::normalize(-m_direction);
    m_u = glm::normalize(glm::cross(m_vup, m_w));
    m_v = glm::cross(m_w, m_u);
  }


  auto Camera::update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void {
    m_aspect_ratio = static_cast<double>(window_width) / static_cast<double>(window_height);
  }

  auto Camera::update_uniforms() noexcept -> void {
    CameraData camera_data{
      glm::vec4(m_vpos, 10.5f),
      glm::vec4(m_u, 0.0f),
      glm::vec4(m_v, 0.0f),
      glm::vec4(m_w, 0.0f),
      m_vfov,
      m_aspect_ratio
    };

    glNamedBufferSubData(m_UBO, 0, sizeof(CameraData), &camera_data);
  }
} // openpt