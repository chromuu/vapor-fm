#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;

void main() {
  vec2 uv = (gl_FragCoord.xy / resolution.xy) * 2.0 - 1.0;
  uv.x *= resolution.x / resolution.y;

  float angle = atan(uv.y, uv.x);
  float dist = length(uv);

  float depth = 0.14 / max(dist, 0.001);
  float motion = time * 0.9;

  float stripeA = sin((depth * 16.0) - motion + angle * 4.0);
  float stripeB = sin((depth * 11.0) - motion * 1.3 - angle * 6.0);
  float ring = smoothstep(0.3, 1.0, stripeA * stripeB * 0.5 + 0.5);

  vec3 tint = mix(vec3(0.02, 0.0, 0.09), vec3(0.0, 0.9, 0.85), ring);
  float vignette = smoothstep(1.35, 0.15, dist);

  gl_FragColor = vec4(tint * vignette, 1.0);
}
