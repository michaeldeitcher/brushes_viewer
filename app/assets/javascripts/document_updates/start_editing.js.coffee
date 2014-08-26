class BrushesViewer.DocumentUpdates.StartEditing
  constructor: (@data) ->
    return

  beginAnimation: ->
    return

  animationSteps: ->
    return 1

  endAnimation: ->
    return

  applyToPaintingAnimated: (step, step_of) ->
    return @canPlayHistoryVersion()

  canPlayHistoryVersion: () ->
    supported = [1, 0, 7]
    digits = @data.historyVersion.split '.'
    (digits[0] > supported[0]) ||
    (digits[0] == supported[0] && digits[1] > supported[1]) ||
    (digits[0] == supported[0] && digits[1] == supported[1] && digits[2] > supported[2])


