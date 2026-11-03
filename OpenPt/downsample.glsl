#version 460 core
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

layout(binding = 0) uniform sampler2D srcTexture;
layout(rgba32f, binding = 0) uniform writeonly image2D outLayer;

layout(location = 0) uniform int srcLevel;
layout(location = 1) uniform bool firstPass;

// Karis average weight: bright groups count less, so single fireflies can't dominate.
float karisWeight(vec3 c) {
	float luma = dot(c, vec3(0.2126, 0.7152, 0.0722));
	return 1.0 / (1.0 + luma);
}

void main() {
	ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
	ivec2 dims = imageSize(outLayer);

	if (any(greaterThanEqual(pixelCoords, dims))) {
		return;
	}

	// Center of this output pixel, in [0, 1].
	vec2 texCoords = (vec2(pixelCoords) + 0.5) / vec2(dims);

	vec2 srcTexelSize = 1.0 / vec2(textureSize(srcTexture, srcLevel));
	float x = srcTexelSize.x;
	float y = srcTexelSize.y;
	float lod = float(srcLevel);

	// a - b - c
	// - j - k -
	// d - e - f
	// - l - m -
	// g - h - i
	// === ('e' is the current texel) ===
	vec3 a = textureLod(srcTexture, vec2(texCoords.x - 2*x, texCoords.y + 2*y), lod).rgb;
	vec3 b = textureLod(srcTexture, vec2(texCoords.x,       texCoords.y + 2*y), lod).rgb;
	vec3 c = textureLod(srcTexture, vec2(texCoords.x + 2*x, texCoords.y + 2*y), lod).rgb;

	vec3 d = textureLod(srcTexture, vec2(texCoords.x - 2*x, texCoords.y), lod).rgb;
	vec3 e = textureLod(srcTexture, vec2(texCoords.x,       texCoords.y), lod).rgb;
	vec3 f = textureLod(srcTexture, vec2(texCoords.x + 2*x, texCoords.y), lod).rgb;

	vec3 g = textureLod(srcTexture, vec2(texCoords.x - 2*x, texCoords.y - 2*y), lod).rgb;
	vec3 h = textureLod(srcTexture, vec2(texCoords.x,       texCoords.y - 2*y), lod).rgb;
	vec3 i = textureLod(srcTexture, vec2(texCoords.x + 2*x, texCoords.y - 2*y), lod).rgb;

	vec3 j = textureLod(srcTexture, vec2(texCoords.x - x, texCoords.y + y), lod).rgb;
	vec3 k = textureLod(srcTexture, vec2(texCoords.x + x, texCoords.y + y), lod).rgb;
	vec3 l = textureLod(srcTexture, vec2(texCoords.x - x, texCoords.y - y), lod).rgb;
	vec3 m = textureLod(srcTexture, vec2(texCoords.x + x, texCoords.y - y), lod).rgb;

	vec3 downsample;
	if (firstPass) {
		vec3 g0 = (a + b + d + e) * 0.25;
		vec3 g1 = (b + c + e + f) * 0.25;
		vec3 g2 = (d + e + g + h) * 0.25;
		vec3 g3 = (e + f + h + i) * 0.25;
		vec3 g4 = (j + k + l + m) * 0.25;

		float w0 = 0.125 * karisWeight(g0);
		float w1 = 0.125 * karisWeight(g1);
		float w2 = 0.125 * karisWeight(g2);
		float w3 = 0.125 * karisWeight(g3);
		float w4 = 0.5   * karisWeight(g4);

		downsample = (g0 * w0 + g1 * w1 + g2 * w2 + g3 * w3 + g4 * w4) / (w0 + w1 + w2 + w3 + w4);
	} else {
		downsample  = e * 0.125;
		downsample += (a + c + g + i) * 0.03125;
		downsample += (b + d + f + h) * 0.0625;
		downsample += (j + k + l + m) * 0.125;
	}

	imageStore(outLayer, pixelCoords, vec4(downsample, 1.0));
}