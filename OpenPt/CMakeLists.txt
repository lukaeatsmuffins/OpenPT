# CMakeList.txt : CMake project for OpenPt, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (OpenPt "main.cpp")

set_property(TARGET OpenPt PROPERTY CXX_STANDARD 23)

add_subdirectory(external)

include_directories(.)

target_link_libraries(OpenPt PRIVATE glfw glad glm)

file(GLOB OPENPT_SOURCES CMAKE_CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
target_sources(OpenPt PRIVATE ${OPENPT_SOURCES})
