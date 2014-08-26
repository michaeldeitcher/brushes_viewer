class BrushesViewer.Controllers.CanvasController
  constructor: ->
    @supported = @checkCompatibility()

  replayPainting: ->
    @replay = new BrushesViewer.Managers.DocumentReplay
    @canvas.painting = BrushesViewer.painting
    @replay.play()

  checkCompatibility: ->
    # Check for the various File API support.
    if window.File and window.FileReader and window.FileList and window.Blob
      # Great success! All the File APIs are supported.
      return true
    else
      alert "The File APIs are not fully supported in this browser."
      return false