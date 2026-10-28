#ifndef CAMERA_H
#define CAMERA_H
#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

namespace openpt {
  class Camera {
    struct alignas(16) CameraData {
      glm::vec3 pos;
      glm::vec3 u;
      glm::vec3 v;
      glm::vec3 w;

      double vfov;
      double aspect_ratio;
    };

  public:
    Camera(double aspect_ratio, double vfov) :
      m_aspect_ratio(aspect_ratio),
      m_vfov(vfov),
      m_vpos(glm::vec3{0.0f,0.0f,1.0f}),
      m_direction(glm::vec3{0.0f,0.0f,-1.0f}),
      m_vup(glm::vec3{0.0f,1.0f,0.0f}),
      m_last_frame(0),
      m_delta_time(0) {
      m_w = glm::normalize(-m_direction);
      m_u = glm::normalize(glm::cross(m_vup, m_w)); 
      m_v = cross(m_w, m_u);
    }

    auto setup() noexcept -> void;
    auto update_aspect_ratio(uint32_t window_width, uint32_t window_height) noexcept -> void;
    auto update_uniforms() noexcept -> void;

  private:
    uint32_t m_UBO;
    double m_aspect_ratio;
    double m_vfov;
    glm::vec3 m_vpos;
    glm::vec3 m_direction;
    glm::vec3 m_vup;

    glm::vec3 m_u;
    glm::vec3 m_v;
    glm::vec3 m_w;

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
