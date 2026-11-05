#include <app.h>

namespace openpt {
  namespace {
    auto framebuffer_resize_cb(GLFWwindow* window, int width, int height) noexcept -> void {
      glViewport(0, 0, width, height);
      auto* app = static_cast<App*>(glfwGetWindowUserPointer(window));
      app->on_framebuffer_resize(width, height);
    }

    auto mouse_event_cb(GLFWwindow* window, double xpos, double ypos) noexcept -> void {
      auto* app = static_cast<App*>(glfwGetWindowUserPointer(window));
      app->on_mouse_event(xpos, ypos);
    }

    auto key_callback(GLFWwindow* window, int key, int scancode, int action, int mods) noexcept -> void {
      if (key == GLFW_KEY_G && action == GLFW_PRESS) {
        auto* app = static_cast<App*>(glfwGetWindowUserPointer(window));
        app->change_gui_mode();
      }
    }
  } // namespace

  auto App::on_framebuffer_resize(uint32_t width, uint32_t height) noexcept -> void {
    m_renderer.update_window(width, height);
    m_camera.update_aspect_ratio(width, height);
  }

  auto App::run() -> void{
    setup_renderer();
    setup_camera();
    loop();
  }

  auto App::setup_callbacks() -> void {
    GLFWwindow* window = m_platform.window();
    glfwSetWindowUserPointer(window, (void*) this);
    glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
    glfwSetCursorPosCallback(window, mouse_event_cb);
    glfwSetKeyCallback(window, key_callback);
    glfwSetFramebufferSizeCallback(window, framebuffer_resize_cb);

    // set up ImGui callbacks after our own so we do not overwrite them.
    ImGui_ImplGlfw_InstallCallbacks(window);
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

    ImGui::SetNextWindowPos(ImVec2(viewport->WorkPos.x + viewport->WorkSize.x - panel_width,
                                   viewport->WorkPos.y));
    ImGui::SetNextWindowSize(ImVec2(panel_width, viewport->WorkSize.y));

    constexpr ImGuiWindowFlags flags = ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoResize |
                                       ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoSavedSettings;

    ImGui::Begin("Settings", nullptr, flags);

    bool changed = false;
    changed |= m_camera.draw_ui();
    changed |= m_renderer.draw_ui();

    if (ImGui::Button("Screenshot")) {
      m_screenshot_requested = true;
    }

    ImGui::End();

    if (changed) {
      m_renderer.reset_sample_counter();
    }
  }

  auto App::change_gui_mode() noexcept -> void {
    m_imgui_mode_on = !m_imgui_mode_on;
    auto mode = m_imgui_mode_on ? GLFW_CURSOR_NORMAL : GLFW_CURSOR_DISABLED;
    glfwSetInputMode(m_platform.window(), GLFW_CURSOR, mode);  
  }

  auto App::process_input() noexcept -> void {
    auto window = m_platform.window();

    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
      glfwSetWindowShouldClose(window, true);
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

  auto App::maybe_screenshot() -> void {
    if (m_screenshot_requested) {
      m_screenshot_requested = false;
      const auto [w, h] = m_renderer.get_dims();
      // todo: maybe display on the UI.
      if (auto result = io::write_png(m_renderer.read_screen(), w, h, "screenshots")) {
        std::println("Saved {}", result->string());
      } else {
        std::println(stderr, "Screenshot failed: {}", result.error());
      }
    }
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

  void App::loop() {
    while (!glfwWindowShouldClose(m_platform.window())) {
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

      maybe_screenshot();

      ImGui::Render();
      ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

      glfwSwapBuffers(m_platform.window());
      glfwPollEvents();
    }
  }
} // openpt