#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;

float noise(vec2 p) {
  return sin(p.x) * sin(p.y);
}

void main() {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 p = (uv - 0.5) * vec2(resolution.x / resolution.y, 1.0);

  float wave = sin((p.x * 4.0) + time * 0.45) * 0.2;
  float band = smoothstep(0.02, -0.18, abs(p.y + wave) - 0.12);

  float glow = 0.0;
  glow += band * 0.6;
  glow += smoothstep(0.2, -0.2, abs(p.y + wave * 1.8) - 0.2) * 0.35;

  float shimmer = noise(vec2(p.x * 16.0 + time * 0.8, p.y * 11.0 - time * 0.4)) * 0.15;

  vec3 sky = vec3(0.01, 0.02, 0.08) + vec3(0.02, 0.01, 0.1) * (1.0 - uv.y);
  vec3 aurora = vec3(0.15, 0.9, 0.45) * glow;
  aurora += vec3(0.25, 0.4, 1.0) * glow * 0.55;
  aurora += shimmer * glow;

  gl_FragColor = vec4(sky + aurora, 1.0);
}
