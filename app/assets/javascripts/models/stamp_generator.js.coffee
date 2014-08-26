kBrushDimension = 512

class BrushesViewer.Models.StampGenerator
  constructor: (@data) ->

  stamp: ->
    blurRadius = 5
    texture_canvas = document.getElementById("texture")
    texture_ctx = texture_canvas.getContext("2d")
    texture_ctx.fillStyle = "black"
    texture_ctx.fillRect blurRadius, blurRadius, kBrushDimension-(2*blurRadius), kBrushDimension-(2*blurRadius)
    stackBlurCanvasRGB( 'texture', 0, 0, kBrushDimension, kBrushDimension, 5 )
    texture_canvas.toDataURL()

  generateStamp: ->

# {"type":"WDRectGenerator",
# "seed":323982985,
# "size":{"type":"size","w":512,"h":512},
# "blurRadius":5,
# "width":1}

