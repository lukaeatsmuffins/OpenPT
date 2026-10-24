#include <stdexcept>

#include <app.h>

namespace openpt {

  namespace {
    auto APIENTRY gl_debug_callback(GLenum source, GLenum type, GLuint id,
                                    GLenum severity, GLsizei length,
                                    const GLchar* message, const void* user_param) noexcept -> void {
        std::println(stderr, "GL: {}", message);
    }
  } // namespace

  void App::run() {
    create_window();
    init_opengl();
    setup_renderer();
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
    glEnable(GL_DEBUG_OUTPUT);
    glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
    glDebugMessageCallback(gl_debug_callback, nullptr);
    glViewport(0, 0, m_window_width, m_window_height);
  }

  auto App::setup_renderer() -> void {
    m_renderer.setup();
  }

  void App::loop() noexcept {
    while (!glfwWindowShouldClose(m_window.get())) {
      m_renderer.display_render();

      glfwSwapBuffers(m_window.get());
      glfwPollEvents();
    }
  }
} // openpt