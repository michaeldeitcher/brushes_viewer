class BrushesViewer.DocumentUpdates.AddPath
  constructor: (@data) ->
    @scale = 1
    @decodeNodes()
    return

  animationSteps: ->
    Math.floor( Math.max( @bezierNodes.length / 8, 1 ) )

  beginAnimation: ->
    @lastRemainder = 0.0
    @partitionPath()

  endAnimation: ->
    return

  applyToPaintingAnimated: (step, step_of) ->
    subpath = new BrushesViewer.Models.Path()
    subpath.setBrush @data.added['brush-id']
    subpath.setColor @data.added.color
    subpath.setNodes @partitions[step-1]
    subpath.setRemainder @lastRemainder
    subpath.setAction 'paint'
    BrushesViewer.painting.paintStroke subpath, (step == 1)
    @lastRemainder = subpath.remainder

  _decodePoint: () ->
    x = @_dataview.getFloat32(@_i)
    @_i += 4
    y = @_dataview.getFloat32(@_i)
    @_i += 4
    z = @_dataview.getFloat32(@_i)
    @_i += 4
    new BrushesViewer.Models.Point x, y, z

# from WDPath::updateWithWDDecoder
  decodeNodes: () ->
    data = StringView.makeFromBase64(this.data.added.cnodes)
    @_dataview = new DataView data.buffer

    @bezierNodes = []
    @_i = 0
    while @_i < @_dataview.byteLength
      inPoint = @_decodePoint()
      anchorPoint = @_decodePoint()
      outPoint = @_decodePoint()
      @bezierNodes.push new BrushesViewer.Models.BezierNode inPoint, anchorPoint, outPoint


  partitionPath: () ->
    numberOfPartitions = @animationSteps()
    partitionSize = Math.floor( @bezierNodes.length / numberOfPartitions )
    ix = 0
    @partitions = []

#    if we're equal to 0 mod the partition size, we need a new array to collect nodes
#    UNLESS we've already created the maximum number of partitions, in which case the
#    remainder can just go in the previously created partition
    for node in @bezierNodes
      if (ix % partitionSize == 0) && @partitions.length < numberOfPartitions
        nodes = []
        @partitions.push nodes
        nodes.push previousNode if previousNode

      nodes.push node
      previousNode = node
      ix++