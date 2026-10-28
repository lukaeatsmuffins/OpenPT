#include <stdexcept>

#include <app.h>

namespace openpt {
  namespace {
    auto APIENTRY gl_debug_callback(GLenum source, GLenum type, GLuint id,
                                    GLenum severity, GLsizei length,
                                    const GLchar* message, const void* user_param) noexcept -> void {
        std::println(stderr, "GL: {}", message);
    }

    auto framebuffer_resize_cb(GLFWwindow* window, int width, int height) noexcept -> void {
      glViewport(0, 0, width, height);
      auto* app = static_cast<App*>(glfwGetWindowUserPointer(window));
      app->on_framebuffer_resize(width, height);
    }
  } // namespace

  auto App::on_framebuffer_resize(uint32_t width, uint32_t height) noexcept -> void {
    m_renderer.update_window(width, height);
    m_camera.update_aspect_ratio(width, height);
  }

  auto App::run() -> void{
    create_window();
    init_opengl();
    setup_renderer();
    setup_camera();
    loop();
  }

  void App::create_window() {
    glm::vec2 window_size = m_renderer.get_window_size();
    m_window = glfw::create_window(window_size.x, window_size.y, m_window_title);
    glfwMakeContextCurrent(m_window.get());
  }

  void App::init_opengl() const {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
      throw std::runtime_error("GLAD: Failed to initialize.");
    }
    glEnable(GL_DEBUG_OUTPUT);
    glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
    glDebugMessageCallback(gl_debug_callback, nullptr);

    glm::vec2 window_size = m_renderer.get_window_size();
    glViewport(0, 0, window_size.x, window_size.y);
    assert(m_window);
    glfwSetWindowUserPointer(m_window.get(), (void*) this);
    glfwSetFramebufferSizeCallback(m_window.get(), framebuffer_resize_cb);
  }

  auto App::setup_renderer() -> void {
    m_renderer.setup();
  }

  auto App::setup_camera() -> void {
    m_camera.setup();
  }

  void App::loop() noexcept {
    while (!glfwWindowShouldClose(m_window.get())) {
      m_camera.update_uniforms();
      m_renderer.display_render();

      glfwSwapBuffers(m_window.get());
      glfwPollEvents();
    }
  }
} // openpt