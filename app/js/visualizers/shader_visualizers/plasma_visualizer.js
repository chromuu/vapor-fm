const ShaderVisualizer = require('js/visualizers/shader_visualizer')

module.exports = class PlasmaVisualizer extends ShaderVisualizer {
  constructor (audioInitializer, renderer) {
    super(audioInitializer, renderer)

    super.LoadResource('shaders/plasma.glsl', (responseText) => {
      this.quadMesh.material.fragmentShader = responseText
      this.quadMesh.material.needsUpdate = true
    })
  }
}
