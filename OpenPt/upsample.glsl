#version 460 core
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

layout(binding = 0) uniform sampler2D srcTexture;
layout(rgba32f, binding = 0) uniform image2D outLayer;

layout(location = 0) uniform int srcLevel;
layout(location = 1) uniform float filterRadius;

void main()
{
	ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
	ivec2 dims = imageSize(outLayer);

	if (any(greaterThanEqual(pixelCoords, dims))) {
		return;
	}

	// Center of this output pixel, in [0, 1].
	vec2 texCoords = (vec2(pixelCoords) + 0.5) / vec2(dims);

	float lod = float(srcLevel);

	// The filter kernel is applied with a radius, specified in texture
	// coordinates, so that the radius will vary across mip resolutions.
	float x = filterRadius;
	float y = filterRadius * float(dims.x) / float(dims.y);

	// Take 9 samples around current texel:
	// a - b - c
	// d - e - f
	// g - h - i
	// === ('e' is the current texel) ===
	vec3 a = textureLod(srcTexture, vec2(texCoords.x - x, texCoords.y + y), lod).rgb;
	vec3 b = textureLod(srcTexture, vec2(texCoords.x,     texCoords.y + y), lod).rgb;
	vec3 c = textureLod(srcTexture, vec2(texCoords.x + x, texCoords.y + y), lod).rgb;

	vec3 d = textureLod(srcTexture, vec2(texCoords.x - x, texCoords.y), lod).rgb;
	vec3 e = textureLod(srcTexture, vec2(texCoords.x,     texCoords.y), lod).rgb;
	vec3 f = textureLod(srcTexture, vec2(texCoords.x + x, texCoords.y), lod).rgb;

	vec3 g = textureLod(srcTexture, vec2(texCoords.x - x, texCoords.y - y), lod).rgb;
	vec3 h = textureLod(srcTexture, vec2(texCoords.x,     texCoords.y - y), lod).rgb;
	vec3 i = textureLod(srcTexture, vec2(texCoords.x + x, texCoords.y - y), lod).rgb;

	// Apply weighted distribution, by using a 3x3 tent filter:
	//  1   | 1 2 1 |
	// -- * | 2 4 2 |
	// 16   | 1 2 1 |
	vec3 upsample = e*4.0;
	upsample += (b+d+f+h)*2.0;
	upsample += (a+c+g+i);
	upsample *= 1.0 / 16.0;


	vec3 current = imageLoad(outLayer, pixelCoords).rgb;
	imageStore(outLayer, pixelCoords, vec4(current + upsample, 1.0));
}
