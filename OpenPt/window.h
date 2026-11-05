#ifndef WINDOW_H
#define WINDOW_H

#include <glad/glad.h>
#include <glfw/glfw3.h>
#include <stdexcept>
#include <memory>

namespace openpt {
  namespace glfw {
    class Context {
    public:
      Context();   // glfwSetErrorCallback, then glfwInit (throw on failure)
      ~Context();  // glfwTerminate

      Context(const Context&) = delete;
      Context& operator=(const Context&) = delete;
    };

    struct WindowDeleter {
      void operator()(GLFWwindow* window) const noexcept;
    };

    using Window = std::unique_ptr<GLFWwindow, WindowDeleter>;

    // Also makes the window's GL context current and loads GLAD.
    [[nodiscard]] Window create_window(int width, int height, const char* title);

  } // glfw

  namespace imgui {
    // Owns Dear ImGui: the context and both backends.
    class Context {
    public:
      explicit Context(GLFWwindow* window);  // GLFW backend callbacks are installed by App
      ~Context();  // OpenGL3 shutdown -> Glfw shutdown -> DestroyContext

      Context(const Context&) = delete;
      Context& operator=(const Context&) = delete;
    };
  } // imgui
} // openpt

#endif // !WINDOW_H
