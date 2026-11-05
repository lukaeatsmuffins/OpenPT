#include <window.h>

#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_opengl3.h>

#include <print>

namespace openpt::glfw {
  namespace {
    auto error_callback(int code, const char* description) noexcept -> void {
      std::println(stderr, "GLFW error {}: {}", code, description);
    }

    auto APIENTRY gl_debug_callback(GLenum source, GLenum type, GLuint id,
                                    GLenum severity, GLsizei length,
                                    const GLchar* message, const void* user_param) noexcept -> void {
      std::println(stderr, "GL: {}", message);
    }
  } // namespace

  Context::Context() {
    glfwSetErrorCallback(error_callback);
    if (!glfwInit()) {
      throw std::runtime_error("GLFW: Failed to initialize.");
    }
  }

  Context::~Context() {
    glfwTerminate();
  }

  void WindowDeleter::operator()(GLFWwindow* window) const noexcept {
    glfwDestroyWindow(window);
  }

  [[nodiscard]] Window create_window(int width, int height, const char* title) {
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);

    Window window{ glfwCreateWindow(width, height, title, nullptr, nullptr) };
    if (!window) {
      throw std::runtime_error("GLFW: Failed to create window.");
    }

    glfwMakeContextCurrent(window.get());
    if (!gladLoadGLLoader(reinterpret_cast<GLADloadproc>(glfwGetProcAddress))) {
      throw std::runtime_error("GLAD: Failed to initialize.");
    }

    glEnable(GL_DEBUG_OUTPUT);
    glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
    glDebugMessageCallback(gl_debug_callback, nullptr);

    return window;
  }

} // openpt::glfw

namespace openpt::imgui {

  Context::Context(GLFWwindow* window) {
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGui::StyleColorsDark();

    ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;

    // ImGui callbacks are registered by App::setup_callbacks().
    ImGui_ImplGlfw_InitForOpenGL(window, false);
    ImGui_ImplOpenGL3_Init("#version 460");
  }

  Context::~Context() {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
  }

} // openpt::imgui
