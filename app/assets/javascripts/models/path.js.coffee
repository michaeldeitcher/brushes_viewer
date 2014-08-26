class BrushesViewer.Models.Path
  constructor: () ->
    @remainder = 0
    @limitBrushSize = false
    @scale = 1

  setBrush: (brush_id) -> @brush = BrushesViewer.painting.getBrush(brush_id)

  setColor: (@color) ->

  setNodes: (@nodes) ->

  setRemainder: (@remainder) ->

  setAction: (@action) ->

  paint: () ->
    @points = []
    @angles = []
    @sizes = []
    @alphas = []

    if @nodes.length == 1
      @_paintStamp()
    else
      points = @_flattenedPoints()
      numPoints = points.length
      ix = 0
      while ix < numPoints - 1
        @_paintFromPoint points[ix], points[ix+1]
        ix++
    @_drawData()

  _flattenedPoints: () ->
    if @nodes.length == 1
      return @nodes[0].anchorPoint

    flatNodes = []
    numOfNodes = @nodes.length - 1
    segment = null
    i = 0
    while i < numOfNodes
      a = @nodes[i]
      b = @nodes[(i+1) % @nodes.length]
      segment = new BrushesViewer.Models.BezierSegment(a, b)
      segment.flattenIntoArray flatNodes
      i++
    flatNodes

  _paintFromPoint: ( lastLocation, location ) ->
    pA = lastLocation.z
    pB = location.z
    pDelta = pB - pA

    distance = BrushesViewer.Utilities.Distance( lastLocation, location )
    vector = location.subtract(lastLocation)
    unitVector = if distance > 0
      vector.multiplyByScaler(1.0/distance)
    else
      new BrushesViewer.Models.Point( 1.0, 1.0 )
    vectorAngle = Math.atan2 vector.y, vector.x

    pressure = pA
    brush = @brush
    weight = @scale * (@limitBrushSize ? 50 : brush.weight)
    start = lastLocation.add( unitVector.multiplyByScaler(@remainder) )

    f = @remainder
    step = 0
    while f <= distance
      brushsize = @brush.weight
      positionalScatter = 0
      orthog = new BrushesViewer.Models.Point( unitVector.y, -unitVector.x )
      orthog = orthog.multiplyByScaler(weight / 2.0 * positionalScatter)
      alpha = brush.data.intensity

      pos = start.add(orthog)
      @points.push pos
      @sizes.push brushsize
      @angles.push vectorAngle
      @alphas.push alpha

      step = Math.max(1.0, @brush.spacing * brushsize);
      start = start.add(unitVector.multiplyByScaler(step))
      f += step
      pressureStep = pDelta / (distance / step)
      pressure += pressureStep

    @remainder = f - distance

#  {"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,
#  "size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},
#  "uuid":"LrD8DCQeSTWPP24zCtOhgQ",
#  "weight":17,
#  "intensity":1,"angle":0,"spacing":0.004,
#  "rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,
#  "intensityDynamics":0}
#   step linearly from last to current, pasting brush image




  _paintStamp: () ->


  _drawData: () ->
    vertexData = []
    dataBounds = null

    i = 0
    while i < @points.length
      result = @points[i]
      angle = @angles[i]
      size = @sizes[i]
      alpha = @alphas[i]
      rect = new Rectangle result.x - size, result.y - size, size*2, size*2
      a = { x: result.x - size/2, y: result.y - size/2}
      b = { x: result.x + size/2, y: result.y - size/2}
      c = { x: result.x - size/2, y: result.y + size/2}
      d = { x: result.x + size/2, y: result.y + size/2}

#      angle rotation here
#      t = new Matrix 1, 0, 0, 1, result.x, result.y
#      t.rotate angle
#      center = rect.center
#      t = t.translate -center.x, -center.y
#      a = t.transform a
#      b = t.transform b
#      c = t.transform c
#      d = t.transform d

      if (vertexData.length != 0)
#       dup 1st vertex
        vertexData.push {x: a.x, y: a.y, s: 0, t: 0, a: alpha}

      vertexData.push {x: a.x, y: a.y, s: 0, t: 0, a: alpha}
      vertexData.push {x: b.x, y: b.y, s: 1, t: 0, a: alpha}
      vertexData.push {x: c.x, y: c.y, s: 0, t: 1, a: alpha}
      vertexData.push {x: d.x, y: d.y, s: 1, t: 1, a: alpha}

      if (i != (@points.length - 1))
#       dup last vertex
        vertexData.push {x: d.x, y: d.y, s: 1, t: 1, a: alpha}
      i++

    i = 0
    arrayBuffer = new Float32Array( vertexData.length * 5 )
    while i < vertexData.length
      vD = vertexData[i]
      arrayBuffer.set([vD.x, vD.y, vD.s, vD.t, vD.a], i*5)
#      console.log "i: #{i} x: #{vD.x} y: #{vD.y} s: #{vD.s} t: #{vD.t} a: #{vD.a}"
      i++

    unless @vertexBuffer?
      @vertexBuffer = BrushesViewer.gl.createBuffer()
      console.log('Failed to create the buffer object') if (!@vertexBuffer)

      # Bind the buffer object to target
      gl = BrushesViewer.gl
      gl.bindBuffer gl.ARRAY_BUFFER, @vertexBuffer

    # Write date into the buffer object
    gl.bufferData gl.ARRAY_BUFFER, arrayBuffer, gl.STATIC_DRAW

    # Assign the buffer object to a_Position variable
    byteSizeOfVertexData = 4 * 5

    inPosition = gl.getAttribLocation(gl.program, "inPosition")
    console.log "Failed to get the storage location"  if inPosition < 0
    gl.vertexAttribPointer inPosition, 2, gl.FLOAT, false, byteSizeOfVertexData, 0
    gl.enableVertexAttribArray inPosition

    inTexcoord = gl.getAttribLocation(gl.program, "inTexcoord")
    console.log "Failed to get the storage location"  if inTexcoord < 0
    offset = 4 * 2
    gl.vertexAttribPointer inTexcoord, 2, gl.FLOAT, false, byteSizeOfVertexData, offset
    gl.enableVertexAttribArray inTexcoord

    alpha = gl.getAttribLocation(gl.program, "alpha")
    console.log "Failed to get the storage location"  if alpha < 0
    offset = 4 * 4
    gl.vertexAttribPointer alpha, 1, gl.FLOAT, false, byteSizeOfVertexData, offset
    gl.enableVertexAttribArray alpha

    gl.drawArrays(gl.TRIANGLE_STRIP, 0, vertexData.length);





