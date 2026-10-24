#include <stdexcept>

#include <app.h>

namespace openpt {
  void App::run() {
    create_window();
    init_opengl();
    loop();
  }

  void App::create_window() {
    m_window = glfw::create_window(m_window_width, m_window_height, m_window_title);
    glfwMakeContextCurrent(m_window.get());
  }

  void App::init_opengl() const {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
      throw std::runtime_error("GLAD: Failed to initialize.");
    }

    glViewport(0, 0, m_window_height, m_window_width);
  }

  void App::loop() noexcept {
    while (!glfwWindowShouldClose(m_window.get())) {
      glfwSwapBuffers(m_window.get());
      glfwPollEvents();
    }
  }

} // openpt