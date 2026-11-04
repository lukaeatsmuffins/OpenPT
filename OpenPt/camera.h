#ifndef CAMERA_H
#define CAMERA_H
#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_opengl3.h>

namespace openpt {
  class Camera {
    struct alignas(16) CameraData {
      alignas(16) glm::vec4 pos;
      alignas(16) glm::vec4 u;
      alignas(16) glm::vec4 v;
      alignas(16) glm::vec4 w;

      float vfov;
      float aspect_ratio;
      float aperture;
      float focus_distance;
    };

  public:
    Camera(float aspect_ratio, float vfov) :
      m_aspect_ratio(aspect_ratio),
      m_vfov(vfov),
      m_vpos(0.0f, 0.0f, 2.5f),
      m_direction(0.0f, 0.0f, -1.0f),
      m_vup(0.0f, 1.0f, 0.0f),
      m_last_frame(0),
      m_delta_time(0),
      m_speed(2.5f),
      m_sensitivity(0.1f),
      m_yaw(-90.0f),
      m_pitch(0.0f),
      m_aperture(0.1f),
      m_focus_distance(1.0f) {
      m_w = glm::normalize(-m_direction);
      m_u = glm::normalize(glm::cross(m_vup, m_w));
      m_v = glm::cross(m_w, m_u);
    }

    ~Camera() {
      glDeleteBuffers(1, &m_UBO);
    }

    auto setup() noexcept -> void;
    auto move_camera(float delta_time, glm::vec3 direction) noexcept -> void;
    auto rotate_camera(float x_offset, float y_offset) noexcept -> void;
    auto update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void;
    auto update_uniforms() const noexcept -> void;
    auto draw_ui() -> bool;

  private:
    auto update_direction(glm::vec3 direction) noexcept -> void;

  private:
    uint32_t m_UBO;
    float m_aspect_ratio;
    float m_vfov;
    glm::vec3 m_vpos;
    glm::vec3 m_direction;
    glm::vec3 m_vup;

    glm::vec3 m_u;
    glm::vec3 m_v;
    glm::vec3 m_w;

    double m_last_frame;
    double m_delta_time;

    float m_speed;
    float m_sensitivity;

    float m_yaw;
    float m_pitch;

    float m_aperture;
    float m_focus_distance;
  };


} // openpt

#endif // !CAMERA_H
