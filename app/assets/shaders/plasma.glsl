#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

void main(void) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 p = uv * 2.0 - 1.0;
  p.x *= resolution.x / resolution.y;

  float waveA = sin((p.x + time * 0.45) * 8.0);
  float waveB = cos((p.y - time * 0.35) * 9.0);
  float waveC = sin((p.x + p.y + time * 0.2) * 12.0);

  float plasma = (waveA + waveB + waveC) / 3.0;

  vec3 color;
  color.r = 0.45 + 0.45 * sin(plasma * 3.2 + time * 0.8);
  color.g = 0.45 + 0.45 * sin(plasma * 2.2 + time * 1.1 + 2.0);
  color.b = 0.45 + 0.45 * sin(plasma * 2.8 + time * 0.9 + 4.0);

  gl_FragColor = vec4(color, 1.0);
}
