#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <print>

#include <app.h>

int main()
{
  try {
    openpt::App app{ 800, 600, "OpenPT" };
    app.run();
  }
  catch (const std::exception& e) {
    std::println("APP Error: {}", e.what());
    return EXIT_FAILURE;
  }
  catch (...) {
    std::println("APP Error: Unknown error");
    return EXIT_FAILURE;
  }
	return EXIT_SUCCESS;
}
