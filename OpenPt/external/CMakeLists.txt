# GLFW: don't build its examples, tests and docs
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS     OFF CACHE BOOL "" FORCE)

# glad: has no CMakeLists of its own, so define its target here
add_library(glad STATIC glad/src/glad.c)
target_include_directories(glad PUBLIC glad/include)

add_subdirectory(glfw)
add_subdirectory(glm)
