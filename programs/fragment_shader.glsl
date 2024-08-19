#version 330

out vec4 fragColor;

uniform vec2 resolution;
uniform float time;

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - resolution.xy) / resolution.y;
    vec3 col = vec3(0.0);

    uv = rotate2D(uv, 3.14 / 2.0);

    float r = 0.17;
    for (float i=0.0; i < 60.0; i++) {
        float factor = (sin(time) * 0.5 + 0.5) * 0.3;
        i += factor;

        float a = i / 3;
        float dx = 2 * r * cos(a) + r * cos(10 * a);
        float dy = 2 * r * sin(a) + r * sin(10 * a);

        col += 0.001 * factor / length(uv - vec2(dx + 0.1, dy));
    }

    col *= sin(vec3(0.2, 0.8, 0.9) * time) * 10;

    fragColor = vec4(col, 1.0);
}
