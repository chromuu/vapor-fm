const ShaderVisualizer = require('js/visualizers/shader_visualizer')

module.exports = class Windows95MazeVisualizer extends ShaderVisualizer {
  constructor (audioInitializer, renderer) {
    super(audioInitializer, renderer)

    super.LoadResource('shaders/windows95_maze.glsl', (responseText) => {
      this.quadMesh.material.fragmentShader = responseText
      this.quadMesh.material.needsUpdate = true
    })
  }
}
