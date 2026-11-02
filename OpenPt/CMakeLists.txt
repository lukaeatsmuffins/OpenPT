# CMakeList.txt : CMake project for OpenPt, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (OpenPt "main.cpp")

set_property(TARGET OpenPt PROPERTY CXX_STANDARD 23)

add_subdirectory(external)

include_directories(.)

target_link_libraries(OpenPt PRIVATE glfw glad glm)

target_compile_definitions(OpenPt PRIVATE SHADER_DIR="${CMAKE_CURRENT_SOURCE_DIR}/")

file(GLOB OPENPT_SOURCES CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
target_sources(OpenPt PRIVATE ${OPENPT_SOURCES})

set(IMGUI_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/imgui)

target_sources(OpenPt PRIVATE
  ${IMGUI_DIR}/imgui.cpp
  ${IMGUI_DIR}/imgui_draw.cpp
	${IMGUI_DIR}/imgui_demo.cpp
  ${IMGUI_DIR}/imgui_tables.cpp
  ${IMGUI_DIR}/imgui_widgets.cpp
  ${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
  ${IMGUI_DIR}/backends/imgui_impl_opengl3.cpp
)
target_include_directories(OpenPt PRIVATE ${IMGUI_DIR} ${IMGUI_DIR}/backends)
