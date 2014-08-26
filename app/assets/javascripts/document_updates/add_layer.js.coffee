class BrushesViewer.DocumentUpdates.AddLayer
  constructor: (@data) ->
    return

  animationSteps: ->
    return 1

  beginAnimation: ->
    @layer = new BrushesViewer.Models.Layer(@data.layer)
    BrushesViewer.painting.insertLayer(@layer)
    return

  endAnimation: ->
    return

  applyToPaintingAnimated: (step, step_of) ->
    return true