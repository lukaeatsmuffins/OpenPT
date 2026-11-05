#include <image_io.h>

#define _CRT_SECURE_NO_WARNINGS
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image_write.h>
#include <stb_image.h>

#include <chrono>
#include <format>
#include <system_error>

namespace openpt::io {
  namespace {
    auto timestamped_name() -> std::string {
      const auto now = std::chrono::floor<std::chrono::seconds>(std::chrono::system_clock::now());
      const std::chrono::zoned_time local{ std::chrono::current_zone(), now };
      return std::format("openpt_{:%Y%m%d_%H%M%S}.png", local);
    }
  } // namespace

  auto write_png(std::span<const std::uint8_t> rgb_pixels,
                 std::uint32_t width, std::uint32_t height,
                 const std::filesystem::path& directory)
    -> std::expected<std::filesystem::path, std::string> {
    constexpr int channels = 3;

    if (rgb_pixels.size() != std::size_t{ width } * height * channels) {
      return std::unexpected("pixel buffer size doesn't match width * height * 3");
    }

    std::error_code ec;
    std::filesystem::create_directories(directory, ec);
    if (ec) {
      return std::unexpected(std::format("can't create '{}': {}", directory.string(), ec.message()));
    }

    const auto path = directory / timestamped_name();

    stbi_flip_vertically_on_write(1);
    const int ok = stbi_write_png(path.string().c_str(),
                                  static_cast<int>(width), static_cast<int>(height), channels,
                                  rgb_pixels.data(), static_cast<int>(width) * channels);
    if (!ok) {
      return std::unexpected(std::format("stbi_write_png failed for '{}'", path.string()));
    }

    return path;
  }

  auto read_png(const std::filesystem::path& path, bool flip_vertically)
    -> std::expected<std::pair<std::vector<float>, glm::uvec3>, std::string> {
    stbi_set_flip_vertically_on_load(flip_vertically);
    int tex_width, tex_height, n_channels;
    float *data = stbi_loadf(path.string().c_str(), &tex_width, &tex_height, &n_channels, 4); 
    if (!data) {
      return std::unexpected(std::format("stbi_load failed for '{}'", path.string()));
    }

    glm::uvec3 size {static_cast<uint32_t>(tex_width), static_cast<uint32_t>(tex_height), static_cast<uint32_t>(n_channels)};
    std::vector<float> im_data(data, data + tex_width * tex_height * 4);

    stbi_image_free(data);

    return std::make_pair(im_data, size);
  }
} // namespace openpt::io