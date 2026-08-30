#version 330 core

// Forge of the Gods - "Pig Star" override v2 (Angelica / GL 3.3 core profile).
// Full-body Microsoft pig emoji, floating: transparent texels are discarded
// (the opaque pass runs with blending disabled, so without discard they would
// render as black). u_Color / u_Gamma stay referenced (the shader recipe
// requires them active); gammaKeep is 1.0 for all sane gamma values.

uniform sampler2D u_Texture;
uniform vec4 u_Color;
uniform float u_Gamma;

in vec2 v_TexCoord;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 tex = texture(u_Texture, v_TexCoord);
    if (tex.a < 0.25) discard;
    float g = max(u_Gamma, 1.0);
    float gammaKeep = g / (g + 0.0001);
    vec4 color = vec4(tex.rgb, u_Color.a * tex.a * gammaKeep);
    if (color.a < 0.1) discard;
    fragColor = color;
}
