#include <window.h>

namespace openpt::glfw {

  void Deleter::operator()(GLFWwindow* window) const noexcept {
    glfwDestroyWindow(window);
  }

  [[nodiscard]] Window create_window(int width, int height, const char* title) {
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    GLFWwindow* window =
      glfwCreateWindow(width, height, title, NULL, NULL);

    if (!window) {
      throw std::runtime_error("GLFW: Failed to create window.");
      return nullptr;
    }

    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    return Window(window);
  }

  void framebuffer_size_callback(GLFWwindow*, int width, int height) noexcept {
    glViewport(0, 0, width, height);
  }

} // openpt::glfw
