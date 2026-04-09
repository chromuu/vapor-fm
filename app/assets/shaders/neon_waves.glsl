#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

void main(void) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 p = uv * 2.0 - 1.0;

  float row = p.y * 6.0;
  float wave = sin((p.x * 10.0) + time * 2.4 + row * 0.8) * 0.12;
  float glowLine = 0.012 / abs(p.y - wave);

  float sideWave = sin((p.x * 6.0) - time * 1.7) * 0.08;
  float glowLine2 = 0.009 / abs(p.y + 0.4 - sideWave);

  vec3 background = vec3(0.02, 0.0, 0.06) + vec3(0.06, 0.0, 0.12) * (1.0 - uv.y);
  vec3 neonMain = vec3(0.1, 1.0, 0.9) * glowLine;
  vec3 neonAccent = vec3(1.0, 0.2, 0.9) * glowLine2;

  vec3 color = background + neonMain + neonAccent;
  color = clamp(color, 0.0, 1.0);

  gl_FragColor = vec4(color, 1.0);
}
