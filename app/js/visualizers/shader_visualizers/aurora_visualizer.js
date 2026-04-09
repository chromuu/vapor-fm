const ShaderVisualizer = require('js/visualizers/shader_visualizer')

module.exports = class AuroraVisualizer extends ShaderVisualizer {
  constructor (audioInitializer, renderer) {
    super(audioInitializer, renderer)

    super.LoadResource('shaders/aurora.glsl', (responseText) => {
      this.quadMesh.material.fragmentShader = responseText
      this.quadMesh.material.needsUpdate = true
    })
  }
}
