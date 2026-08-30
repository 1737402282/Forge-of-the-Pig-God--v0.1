#version 120

// Forge of the Gods - "Pig Star" v5 (legacy GL 2.1 profile).
// The star sphere is replaced by a FLAT, CAMERA-FACING billboard at the star
// center: the pig emoji is always fully visible, never rotates away, and has
// a fixed world size (relative to the star radius).

attribute vec3 a_Position;
attribute vec2 a_UV;

uniform mat4 u_ModelMatrix;

varying vec2 v_TexCoord;

void main() {
    v_TexCoord = a_UV;

    // Star center (world) = translation part of the model matrix.
    vec3 center = u_ModelMatrix[3].xyz;
    // Star radius = length of a model-matrix column (uniform scale).
    float r = length(u_ModelMatrix[0].xyz);

    // Star center in view space, then offset along the view plane
    // (camera-facing). Quad size = 1.2 * star radius in world blocks (2x).
    vec4 viewCenter = gl_ModelViewMatrix * vec4(center, 1.0);
    float QW = 1.2;
    float QH = 1.2;
    // Keep a_Position referenced (the shader recipe requires the attribute
    // to be active); it only adds a sub-millimeter jitter.
    vec3 jitter = a_Position * 0.001;
    vec4 pos = viewCenter + vec4((a_UV.x - 0.5) * (QW * r) + jitter.x,
                                 (0.5 - a_UV.y) * (QH * r) + jitter.y,
                                 jitter.z, 0.0);
    gl_Position = gl_ProjectionMatrix * pos;
}
