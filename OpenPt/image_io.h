#ifndef IMAGE_IO_H
#define IMAGE_IO_H

#include <cstdint>
#include <expected>
#include <filesystem>
#include <span>
#include <string>
#include <glm/glm.hpp>

namespace openpt::io {
  // writes opengl buffer contents to a timestamped PNG in `directory`.
  // returns the written path, or an error message.
  [[nodiscard]] auto write_png(std::span<const std::uint8_t> rgb_pixels,
                               std::uint32_t width, std::uint32_t height,
                               const std::filesystem::path& directory)
    -> std::expected<std::filesystem::path, std::string>;

  [[nodiscard]] auto read_png(const std::filesystem::path& path, bool flip_vertically = true)
    -> std::expected<std::pair<std::vector<float>, glm::uvec3>, std::string>;
} // namespace openpt::io

#endif // !IMAGE_IO_H