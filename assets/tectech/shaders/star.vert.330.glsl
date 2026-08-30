#version 330 core

// Forge of the Gods - "Pig Star" v5 (Angelica / GL 3.3 core profile).
// The star sphere is replaced by a FLAT, CAMERA-FACING billboard at the star
// center: the pig emoji is always fully visible, never rotates away, and has
// a fixed world size (relative to the star radius). The quad size and aspect
// are derived from u_MVP itself (projected model axes), so it stays correct
// at any FOV / resolution.

in vec3 a_Position;
in vec2 a_UV;

uniform mat4 u_MVP;

out vec2 v_TexCoord;

void main() {
    v_TexCoord = a_UV;

    // Star center in clip space (translation part of u_MVP; rotation-free).
    vec4 c = u_MVP * vec4(0.0, 0.0, 0.0, 1.0);

    // Projected unit model axes (u_MVP includes the star radius scale):
    //   sx = f*r/aspect, sy = f*r  (f = projection scale, r = star radius).
    // Their squared sums are invariant under the star's rotation.
    vec3 d0 = (u_MVP * vec4(1.0, 0.0, 0.0, 1.0)).xyz - c.xyz;
    vec3 d1 = (u_MVP * vec4(0.0, 1.0, 0.0, 1.0)).xyz - c.xyz;
    vec3 d2 = (u_MVP * vec4(0.0, 0.0, 1.0, 1.0)).xyz - c.xyz;
    float sx = sqrt(d0.x * d0.x + d1.x * d1.x + d2.x * d2.x);
    float sy = sqrt(d0.y * d0.y + d1.y * d1.y + d2.y * d2.y);

    // Billboard quad size relative to the star radius (1.2 * radius = 2x).
    float QW = 1.2;
    float QH = 1.2;
    // Keep a_Position referenced (the shader recipe requires the attribute
    // to be active); it only adds a sub-millimeter jitter, the billboard
    // stays flat and camera-facing.
    vec3 jitter = a_Position * 0.001;
    gl_Position = c + vec4((a_UV.x - 0.5) * (QW * sx) + jitter.x,
                           (0.5 - a_UV.y) * (QH * sy) + jitter.y,
                           jitter.z, 0.0);
}
