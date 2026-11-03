#ifndef BLOOM_H
#define BLOOM_H
 
#include <cstdint>
 
namespace openpt {
  class Bloom {
  public:
    struct Settings {
      float strength{ 0.04f };
      float filter_radius{ 0.005f };
      int levels{ 6 };
    };
 
    Bloom(std::uint32_t width, std::uint32_t height);
    ~Bloom();
 
    Bloom(const Bloom&) = delete;
    Bloom& operator=(const Bloom&) = delete;
 
    auto setup() -> void;
 
    auto resize(std::uint32_t width, std::uint32_t height) noexcept -> void;
 
    auto apply(std::uint32_t source_tex) noexcept -> void;
 
    [[nodiscard]] auto output_texture() const noexcept -> std::uint32_t;
    [[nodiscard]] auto strength() const noexcept -> float;
 
    auto draw_ui() -> bool;
 
  private:
    auto create_chain() -> void;
    auto destroy_chain() noexcept -> void;
    auto downsample_pass(std::uint32_t source) noexcept -> void;
    auto upsample_pass() noexcept -> void;
 
    std::uint32_t m_width;
    std::uint32_t m_height;
 
    std::uint32_t m_chain{};
    std::uint32_t m_level_count{};
    std::uint32_t m_sampler{};
 
    std::uint32_t m_downsample_program{};
    std::uint32_t m_upsample_program{};

    static constexpr char m_dwnsmpl_shdr_path[] = SHADER_DIR "downsample.glsl";
    static constexpr char m_upsmpl_shdr_path[] = SHADER_DIR "upsample.glsl";

    static constexpr std::uint32_t min_dim_size = 8;
 
    Settings m_settings{};
  };
} // openpt
 
#endif // !BLOOM_H
