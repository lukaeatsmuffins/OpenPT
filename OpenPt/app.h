#ifndef APP_H
#define APP_H

#include <window.h>
#include <renderer.h>
#include <camera.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_opengl3.h>

#include <stdexcept>
#include <print>
#include <memory>

namespace openpt {
	class App {
  public: 

    App(int window_width, int window_height, const char* app_title):
      m_window_title(app_title),
      m_renderer(window_width, window_height),
      m_camera(static_cast<double>(window_width)/static_cast<double>(window_height), 45.0),
      m_last_frame(0.0f),
      m_delta_time(0.0f),
      first_mouse_event(true),
      last_x(0.0),
      last_y(0.0),
      m_imgui_mode_on(false) {
      if (!glfwInit()) {
        throw std::runtime_error("APP: Failed to initialize GLFW");
      };
      // TODO: setup GLFW error callback.
    }

    ~App() {
      // TODO: this is not going to work due to lifetimes.
      // fix this later.
      ImGui_ImplOpenGL3_Shutdown();
      ImGui_ImplGlfw_Shutdown();
      ImGui::DestroyContext();
      glfwTerminate();
    }

    void run();

    auto on_framebuffer_resize(uint32_t width, uint32_t height) noexcept -> void;

    auto on_mouse_event(double xpos, double ypos) noexcept -> void;

    auto change_gui_mode() noexcept -> void;

  private:
    const char* m_window_title{};

    glfw::Window m_window{};
    Renderer m_renderer;
    Camera m_camera;
    float m_last_frame;
    float m_delta_time;
    bool first_mouse_event;
    double last_x;
    double last_y;
    bool m_imgui_mode_on;

  private:
    auto create_window() -> void;
    auto init_opengl() const -> void;
    auto init_imgui() -> void;
    auto setup_renderer() -> void;
    auto setup_camera() -> void;
    auto draw_ui() -> void;
    auto loop() noexcept -> void;
    auto process_input() noexcept -> void;
    auto update_time() noexcept -> void;
	};
} // openpt

#endif // !APP_H
