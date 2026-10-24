#ifndef APP_H
#define APP_H

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <window.h>

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

  private:
    void create_window();
    void init_opengl() const;
    void loop() noexcept;

	};
} // openpt

#endif // !APP_H
