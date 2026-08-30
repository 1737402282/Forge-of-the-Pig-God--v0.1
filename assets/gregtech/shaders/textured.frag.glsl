#version 120

// Forge of the Gods - "Pig Star" pack: Eye of Harmony star HIDDEN (legacy).
// See textured.frag.330.glsl for the explanation.

uniform sampler2D u_Texture;
uniform vec4 u_Tint;

varying vec2 v_TexCoord;

void main() {
    vec4 t = texture2D(u_Texture, v_TexCoord);
    bool eohStar = (abs(u_Tint.r - 1.0) < 0.05 &&
                    abs(u_Tint.g - 0.4) < 0.05 &&
                    abs(u_Tint.b - 0.05) < 0.05);
    if (eohStar) {
        discard;
    }
    gl_FragColor = t * u_Tint;
}
