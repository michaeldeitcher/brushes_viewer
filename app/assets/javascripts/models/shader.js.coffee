class BrushesViewer.Models.Shader
  constructor: (@vertex, @fragment) ->
    @program = createProgram(BrushesViewer.gl, @vertex, @fragment)
    console.log "Failed to create program"  unless @program
