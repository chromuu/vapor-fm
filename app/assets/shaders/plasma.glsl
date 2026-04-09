#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;

float field(vec2 p) {
  float accum = 0.0;
  accum += sin((p.x * 8.0) + (time * 1.2));
  accum += sin((p.y * 7.0) - (time * 1.4));
  accum += sin((p.x + p.y) * 6.0 + (time * 0.9));
  accum += sin(length(p * 4.0) * 5.0 - (time * 1.6));
  return accum * 0.25;
}

void main() {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 p = (uv - 0.5) * vec2(resolution.x / resolution.y, 1.0);

  float v = field(p);

  vec3 color = vec3(
    0.5 + 0.5 * sin(6.2831 * v + time * 0.4),
    0.5 + 0.5 * sin(6.2831 * v + 2.1 + time * 0.5),
    0.5 + 0.5 * sin(6.2831 * v + 4.2 + time * 0.6)
  );

  gl_FragColor = vec4(color, 1.0);
}
