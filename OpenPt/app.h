#ifndef APP_H
#define APP_H

#include <window.h>
#include <renderer.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <stdexcept>
#include <print>
#include <memory>

namespace openpt {
	class App {
  public: 

    App(int window_width, int window_height, const char* app_title):
      m_window_width(window_width),
      m_window_height(window_height),
      m_window_title(app_title),
      m_renderer(*this) {
      if (!glfwInit()) {
        throw std::runtime_error("APP: Failed to initialize GLFW");
      };
      // TODO: setup GLFW error callback.
    }

    ~App() {
      // TODO: this is not going to work due to lifetimes.
      // fix this later.
      glfwTerminate();
    }

    void run();

    auto window_width() const -> int;
    auto window_height() const -> int;

  private:
    int m_window_width{};
    int m_window_height{};
    const char* m_window_title{};

    glfw::Window m_window{};
    Renderer m_renderer;

  private:
    auto create_window() -> void;
    auto init_opengl() const -> void;
    auto setup_renderer() -> void;
    auto loop() noexcept -> void;

	};
} // openpt

#endif // !APP_H
