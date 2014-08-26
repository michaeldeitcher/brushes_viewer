class BrushesViewer.Models.Point
  constructor: (@x = 0, @y = 0, @z = 0) ->

  isEqual: (pt) ->
    return false unless pt

  add: ( pt ) ->
    x = @x + pt.x
    y = @y + pt.y
    z = @z + pt.z
    new BrushesViewer.Models.Point( x, y, z )

  subtract: ( pt ) ->
    x = @x - pt.x
    y = @y - pt.y
    z = @z - pt.z
    new BrushesViewer.Models.Point( x, y, z )

  multiplyByScaler: (scaler) ->
    x = @x * scaler
    y = @y * scaler
    z = @z * scaler
    new BrushesViewer.Models.Point( x, y, z )

