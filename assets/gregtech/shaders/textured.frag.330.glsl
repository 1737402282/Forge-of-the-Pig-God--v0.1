#version 330 core

// Forge of the Gods - "Pig Star" pack: Eye of Harmony star HIDDEN (core).
// The EOH star is drawn with the SHARED "textured" shader with the unique
// tint (1.0, 0.4, 0.05). When that tint is present we discard every fragment,
// so the EOH star is not rendered at all (the EOH space shell and orbits are
// unaffected; the Forge of the Gods pig uses its own shader). Every other
// user of this shader keeps the original texture * u_Tint behavior.

uniform sampler2D u_Texture;
uniform vec4 u_Tint;

in vec2 v_TexCoord;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 t = texture(u_Texture, v_TexCoord);
    bool eohStar = (abs(u_Tint.r - 1.0) < 0.05 &&
                    abs(u_Tint.g - 0.4) < 0.05 &&
                    abs(u_Tint.b - 0.05) < 0.05);
    if (eohStar) {
        discard;
    }
    vec4 color = t * u_Tint;
    if (color.a < 0.1) discard;
    fragColor = color;
}
