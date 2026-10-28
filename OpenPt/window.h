#ifndef WINDOW_H
#define WINDOW_H

#include <glad/glad.h>
#include <glfw/glfw3.h>
#include <stdexcept>
#include <memory>

namespace openpt::glfw {
  struct Deleter {
    void operator()(GLFWwindow* window) const noexcept;
  };

  using Window = std::unique_ptr<GLFWwindow, Deleter>;

  [[nodiscard]] Window create_window(int width, int height, const char* title);

} // openpt::glfw

#endif // !WINDOW_H
