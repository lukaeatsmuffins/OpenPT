#ifndef CAMERA_H
#define CAMERA_H
#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

namespace openpt {
  class Camera {
    struct alignas(16) CameraData {
      glm::vec4 pos;
      glm::vec4 u;
      glm::vec4 v;
      glm::vec4 w;

      double vfov;
      double aspect_ratio;
    };

  public:
    Camera(double aspect_ratio, double vfov) :
      m_aspect_ratio(aspect_ratio),
      m_vfov(vfov),
      m_vpos(glm::vec4{0.0f,0.0f,1.0f, 1.0f}),
      m_direction(glm::vec4{0.0f,0.0f,-1.0f, 0.0f}),
      m_vup(glm::vec4{0.0f,1.0f,0.0f,0.0f}),
      m_last_frame(0),
      m_delta_time(0) {
      auto w = glm::normalize(glm::vec3(-m_direction));
      auto u = glm::normalize(glm::cross(glm::vec3(m_vup), w)); 
      auto v = glm::cross(w, u);
      m_w = glm::vec4(w, 0.0f);
      m_u = glm::vec4(u, 0.0f);
      m_v = glm::vec4(v, 0.0f);
    }

    auto setup() noexcept -> void;
    auto update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void;
    auto update_uniforms() noexcept -> void;

  private:
    uint32_t m_UBO;
    double m_aspect_ratio;
    double m_vfov;
    glm::vec4 m_vpos;
    glm::vec4 m_direction;
    glm::vec4 m_vup;

    glm::vec4 m_u;
    glm::vec4 m_v;
    glm::vec4 m_w;

    double m_last_frame;
    double m_delta_time;
  };

  //void processInput(GLFWwindow* window) {
    //if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    //  glfwSetWindowShouldClose(window, true);
    //}
    //const float camera_speed = 2.5f * m_delta_time;

      //if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
      //    cameraPos += cameraSpeed * cameraDirection;
      //if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
      //    cameraPos -= cameraSpeed * cameraDirection;
      //if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
      //    cameraPos -= glm::normalize(glm::cross(cameraDirection, cameraUp)) * cameraSpeed;
      //if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
      //    cameraPos += glm::normalize(glm::cross(cameraDirection, cameraUp)) * cameraSpeed;
  //}

} // openpt

#endif // !CAMERA_H
