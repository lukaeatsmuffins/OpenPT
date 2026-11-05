#ifndef APP_H
#define APP_H

#include <window.h>
#include <renderer.h>
#include <camera.h>
#include <image_io.h>

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
      m_platform(window_width, window_height, app_title),
      m_renderer(window_width, window_height),
      m_camera(static_cast<double>(window_width)/static_cast<double>(window_height), 45.0),
      m_last_frame(0.0f),
      m_delta_time(0.0f),
      first_mouse_event(true),
      last_x(0.0),
      last_y(0.0),
      m_imgui_mode_on(false),
      m_screenshot_requested(false) {
      setup_callbacks();
    }

    App(const App&) = delete;
    App& operator=(const App&) = delete;

    void run();

    auto on_framebuffer_resize(uint32_t width, uint32_t height) noexcept -> void;

    auto on_mouse_event(double xpos, double ypos) noexcept -> void;

    auto change_gui_mode() noexcept -> void;

  private:
    // Owns GLFW, the window (+ GL context) and ImGui. Members are in setup order,
    // so they're destroyed in reverse: ImGui -> window -> GLFW.
    class Platform {
    public:
      Platform(int width, int height, const char* title) :
        m_window(glfw::create_window(width, height, title)),
        m_imgui(m_window.get()) {}

      [[nodiscard]] auto window() const noexcept -> GLFWwindow* { return m_window.get(); }

    private:
      glfw::Context   m_glfw;
      glfw::Window    m_window;
      imgui::Context  m_imgui;
    };

    // Declared first: everything below needs the window and GL.
    Platform m_platform;
    Renderer m_renderer;
    Camera m_camera;
    float m_last_frame;
    float m_delta_time;
    bool first_mouse_event;
    double last_x;
    double last_y;
    bool m_imgui_mode_on;
    bool m_screenshot_requested;

  private:
    auto setup_callbacks() -> void;
    auto setup_renderer() -> void;
    auto setup_camera() -> void;
    auto draw_ui() -> void;
    auto loop() -> void;
    auto process_input() noexcept -> void;
    auto update_time() noexcept -> void;
    auto maybe_screenshot() -> void;
	};
} // openpt

#endif // !APP_H
