#version 120

// Forge of the Gods - "Pig Star" override v2 (legacy GL 2.1 profile).
// Full-body Microsoft pig emoji, floating: transparent texels are discarded
// (the opaque pass runs with blending disabled, so without discard they would
// render as black). u_Color / u_Gamma stay referenced (the shader recipe
// requires them active); gammaKeep is 1.0 for all sane gamma values.

uniform sampler2D u_Texture;
uniform vec4 u_Color;
uniform float u_Gamma;

varying vec2 v_TexCoord;

void main() {
    vec4 tex = texture2D(u_Texture, v_TexCoord);
    if (tex.a < 0.25) discard;
    float g = max(u_Gamma, 1.0);
    float gammaKeep = g / (g + 0.0001);
    gl_FragColor = vec4(tex.rgb, u_Color.a * tex.a * gammaKeep);
}
