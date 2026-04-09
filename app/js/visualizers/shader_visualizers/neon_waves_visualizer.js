const ShaderVisualizer = require('js/visualizers/shader_visualizer')

module.exports = class NeonWavesVisualizer extends ShaderVisualizer {
  constructor (audioInitializer, renderer) {
    super(audioInitializer, renderer)

    super.LoadResource('shaders/neon_waves.glsl', (responseText) => {
      this.quadMesh.material.fragmentShader = responseText
      this.quadMesh.material.needsUpdate = true
    })
  }
}
