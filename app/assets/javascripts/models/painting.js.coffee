gl = undefined
class BrushesViewer.Models.Painting
  constructor: (@data) ->
    @w = @data.dimensions.w
    @h = @data.dimensions.h
    @strokeCount = @data.strokeCount
    @layers = []
    projectionMatrix = make2DProjection(@w, @h, @w)
    @projection_matrix = new Float32Array(projectionMatrix)
    @loadBrushes(@data.brushes)
    @initWebGL()

  initWebGL: ->
    @$canvas = $('#brushesViewer')
    @$canvas.width @w
    @$canvas.height @h
    @canvas = @$canvas[0]

    gl = BrushesViewer.gl = getWebGLContext(@canvas)
    gl.enable(gl.BLEND)
    gl.disable(gl.DITHER)
    gl.disable(gl.STENCIL_TEST)
    gl.disable(gl.DEPTH_TEST)
    @loadShaders()
    @currentFrameBufferIndex = 0

  loadShaders: ->
#    @simple_shader = new BrushesViewer.Models.Shader( BrushesViewer.Shaders.simple_vertex, BrushesViewer.Shaders.simple_fragment )
#    @apply_texture_shader  = new BrushesViewer.Models.Shader( BrushesViewer.Shaders.apply_texture_vertex, BrushesViewer.Shaders.apply_texture_fragment )
    @brush_shader  = new BrushesViewer.Models.Shader( BrushesViewer.Shaders.brush_vertex, BrushesViewer.Shaders.brush_fragment )
#    @blit_mask_shader  = new BrushesViewer.Models.Shader( BrushesViewer.Shaders.blit_vertex, BrushesViewer.Shaders.blit_with_mask_fragment )


  insertLayer: (layer) ->
    @layers.push(layer)

  loadBrushes: (data) ->
    @brushes = {}
    @loadBrush(object) for object in data.objects

  loadBrush: (data) ->
    return unless data.uuid?
    @brushes[data.uuid] = new BrushesViewer.Models.Brush(data)

  getBrush: (uuid) ->
    @brushes[uuid]

  brushTexture: (brush) ->
    if @_lastBrush == brush && @_brushTexture?
      @_brushTexture
    else
      @_lastBrush = brush
      @_brushTexture = new BrushesViewer.Models.Texture @_lastBrush.generator.stamp()

  configureBrush: (brush) ->
    gl.useProgram @brush_shader.program
    gl.program = @brush_shader.program

    gl.activeTexture(gl.TEXTURE0);
    gl.bindTexture(gl.TEXTURE_2D, @brushTexture(brush).textureName);

    gl.uniform1i(gl.getUniformLocation(gl.program, 'texture'), 0)
    gl.uniformMatrix4fv(gl.getUniformLocation(gl.program, 'modelViewProjectionMatrix'), false, @projection_matrix);

  paintStroke: (path, clearBuffer) ->
    @activePath = path

#    if clearBuffer
#      gl.clearColor(0, 0, 0, 0)
#      gl.clear(gl.COLOR_BUFFER_BIT)
    @configureBrush(path.brush)
    path.paint()