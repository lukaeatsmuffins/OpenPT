#ifndef APP_H
#define APP_H

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <window.h>
#include <renderer.h>

namespace openpt {
	class App {

  public: 
    App(int window_width, int window_height, const char* app_title):
      m_window_width(window_width),
      m_window_height(window_height),
      m_window_title(app_title) {
      glfwInit();
    }

    ~App() {
      glfwTerminate();
    }

    void run();

  private:
    int m_window_height{};
    int m_window_width{};
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
