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

    auto mouse_event_cb(GLFWwindow* window, double xpos, double ypos) noexcept -> void {
      auto* app = static_cast<App*>(glfwGetWindowUserPointer(window));
      app->on_mouse_event(xpos, ypos);
    }
  } // namespace

  auto App::on_framebuffer_resize(uint32_t width, uint32_t height) noexcept -> void {
    m_renderer.update_window(width, height);
    m_camera.update_aspect_ratio(width, height);
  }

  auto App::run() -> void{
    create_window();
    init_opengl();
    init_imgui();
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
    assert(m_window);
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
      throw std::runtime_error("GLAD: Failed to initialize.");
    }
    glEnable(GL_DEBUG_OUTPUT);
    glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
    glDebugMessageCallback(gl_debug_callback, nullptr);

    glm::vec2 window_size = m_renderer.get_window_size();
    glViewport(0, 0, window_size.x, window_size.y);
    glfwSetWindowUserPointer(m_window.get(), (void*) this);
    glfwSetInputMode(m_window.get(), GLFW_CURSOR, GLFW_CURSOR_DISABLED);  
    glfwSetCursorPosCallback(m_window.get(), mouse_event_cb);  
    glfwSetFramebufferSizeCallback(m_window.get(), framebuffer_resize_cb);
  }

  void App::init_imgui() {
    assert(m_window);
    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGui::StyleColorsDark();
    ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;

    ImGui_ImplGlfw_InitForOpenGL(m_window.get(), true);
    ImGui_ImplOpenGL3_Init("#version 460");
  }

  auto App::setup_renderer() -> void {
    m_renderer.setup();
  }

  auto App::setup_camera() -> void {
    m_camera.setup();
  }

  auto App::draw_ui() -> void {
    const ImGuiViewport* viewport = ImGui::GetMainViewport();
    constexpr float panel_width = 300.0f;

    // Pin to the right edge, full height, every frame (so window resizes are followed).
    ImGui::SetNextWindowPos(ImVec2(viewport->WorkPos.x + viewport->WorkSize.x - panel_width,
                                   viewport->WorkPos.y));
    ImGui::SetNextWindowSize(ImVec2(panel_width, viewport->WorkSize.y));

    constexpr ImGuiWindowFlags flags = ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoResize |
                                       ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoSavedSettings;

    ImGui::Begin("Settings", nullptr, flags);

    bool changed = false;
    changed |= m_camera.draw_ui();
    changed |= m_renderer.draw_ui();

    ImGui::End();

    if (changed) {
      m_renderer.reset_sample_counter();
    }
  }

  auto App::process_input() noexcept -> void {
    auto window = m_window.get();

    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
      glfwSetWindowShouldClose(m_window.get(), true);
    }

    if (glfwGetKey(window, GLFW_KEY_G) == GLFW_PRESS) {
      m_imgui_mode_on = !m_imgui_mode_on;
      auto mode = m_imgui_mode_on ? GLFW_CURSOR_NORMAL : GLFW_CURSOR_DISABLED;
      glfwSetInputMode(m_window.get(), GLFW_CURSOR, mode);  
    }

    if (m_imgui_mode_on) {
      return;
    }
    
    glm::vec3 direction{0};
    bool moved{ false };
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
        direction += glm::vec3(0, 0, -1);
        moved = true;
    }
      
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
        direction += glm::vec3(0, 0, 1);
        moved = true;
    }
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
        direction += glm::vec3(-1, 0, 0);
        moved = true;
    }
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
        direction += glm::vec3(1, 0, 0);
        moved = true;
    }
    if (glfwGetKey(window, GLFW_KEY_SPACE) == GLFW_PRESS) {
        direction += glm::vec3(0, 1, 0);
        moved = true;
    }
    if (glfwGetKey(window, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS) {
        direction += glm::vec3(0, -1, 0);
        moved = true;
    }

    if (moved) {
      m_camera.move_camera(m_delta_time, direction);
      m_renderer.reset_sample_counter();
    }
  }

  auto App::update_time() noexcept -> void {
		float current_frame = glfwGetTime();
		m_delta_time = current_frame - m_last_frame;
		m_last_frame = current_frame;  
  }

  auto App::on_mouse_event(double xpos, double ypos) noexcept -> void {
    
    // Processing GUI input.
    if (m_imgui_mode_on) {
      first_mouse_event = true;
      return;
    }

    if (first_mouse_event) {
      last_x = xpos;
      last_y = ypos;
      first_mouse_event = false;
    }

    float xoffset = xpos - last_x;
    // y coordinate is top to bottom.
    float yoffset = last_y - ypos;

    last_x = xpos;
    last_y = ypos;
    
    bool moved = (xoffset != 0.0f || yoffset != 0.0f);
    if (moved) {
      m_camera.rotate_camera(xoffset, yoffset);
      m_renderer.reset_sample_counter();
    }
  }

  void App::loop() noexcept {
    while (!glfwWindowShouldClose(m_window.get())) {
      ImGui_ImplOpenGL3_NewFrame();
      ImGui_ImplGlfw_NewFrame();
      ImGui::NewFrame();
      if (m_imgui_mode_on) {
        draw_ui();
      }

      update_time();
      process_input();

      m_camera.update_uniforms();
      m_renderer.display_render();

      ImGui::Render();
      ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

      glfwSwapBuffers(m_window.get());
      glfwPollEvents();
    }
  }
} // openpt