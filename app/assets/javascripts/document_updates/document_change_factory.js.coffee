class BrushesViewer.DocumentUpdates.DocumentChangeFactory
  constructor: ->

  makeDocumentChange: (data) ->
    switch data.type
      when 'WDStartEditing'
        new BrushesViewer.DocumentUpdates.StartEditing(data)
      when 'WDAddLayer'
        new BrushesViewer.DocumentUpdates.AddLayer(data)
      when 'WDClearUndoStack'
        new BrushesViewer.DocumentUpdates.ClearUndoStack(data)
      when 'WDAddPath'
        new BrushesViewer.DocumentUpdates.AddPath(data)
      else
        new BrushesViewer.DocumentUpdates.BlankChange(data)


