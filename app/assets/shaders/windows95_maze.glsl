#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

float hash21(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

void main(void) {
  vec2 uv = (gl_FragCoord.xy / resolution.xy) * 2.0 - 1.0;
  uv.x *= resolution.x / resolution.y;

  float t = time * 1.8;
  float lane = floor((uv.x + 1.0) * 4.0);
  float laneOffset = (hash21(vec2(lane, floor(t * 0.65))) - 0.5) * 1.1;

  float z = 1.0 / max(uv.y + 1.15, 0.08);
  vec2 pos = vec2(uv.x + laneOffset, z + t * 2.4);

  vec2 cell = floor(pos);
  vec2 local = fract(pos) - 0.5;

  float wallSeed = hash21(cell + vec2(17.0, 39.0));
  float verticalSeed = hash21(cell + vec2(91.0, 7.0));

  float horizWall = step(0.62, wallSeed) * smoothstep(0.14, 0.03, abs(local.y));
  float vertWall = step(0.70, verticalSeed) * smoothstep(0.14, 0.03, abs(local.x));

  float sideWall = smoothstep(0.02, 0.18, abs(uv.x) - 0.62);
  float maze = max(max(horizWall, vertWall), sideWall);

  vec3 wallColor = vec3(0.08, 0.78, 1.0);
  vec3 bgColor = vec3(0.0, 0.01, 0.03);

  float depthFog = smoothstep(2.8, 0.2, z);
  vec3 color = mix(bgColor, wallColor, maze * depthFog);

  float floorLine = smoothstep(0.0, 0.2, sin((z + t) * 10.0) * 0.5 + 0.5);
  color += vec3(0.0, 0.03, 0.05) * floorLine * (1.0 - maze) * depthFog;

  gl_FragColor = vec4(color, 1.0);
}
