#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

void main(void) {
  vec2 uv = (gl_FragCoord.xy / resolution.xy) * 2.0 - 1.0;
  uv.x *= resolution.x / resolution.y;

  float angle = atan(uv.y, uv.x);
  float radius = length(uv);

  float rings = sin((1.0 / max(radius, 0.001)) * 0.9 - time * 2.6);
  float streaks = sin(angle * 8.0 + time * 1.8);

  float pulse = 0.5 + 0.5 * sin(time * 1.2);
  vec3 base = vec3(0.08, 0.04, 0.2);
  vec3 accent = vec3(0.25, 0.9, 1.0);

  float brightness = smoothstep(-0.8, 0.9, rings + streaks * 0.35);
  brightness *= smoothstep(1.2, 0.0, radius);

  vec3 color = mix(base, accent, brightness * (0.6 + pulse * 0.4));
  gl_FragColor = vec4(color, 1.0);
}
