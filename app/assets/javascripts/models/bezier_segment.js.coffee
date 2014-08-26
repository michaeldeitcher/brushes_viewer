class BrushesViewer.Models.BezierSegment
  kDefaultFlatness: 1

  constructor: ( start, end ) ->
    return if start == undefined
    @start = start.anchorPoint
    @outHandle = start.outPoint
    @inHandle = end.inPoint
    @end = end.anchorPoint

  isFlatWithTolerance: (tolerance) ->
    return true if @start == @outHandle && @end == @inHandle
    dx = @end.x - @start.x
    dy = @end.y - @start.y
    d2 = Math.abs((@outHandle.x - @end.x) * dy - (@outHandle.y - @end.y) * dx)
    d3 = Math.abs((@inHandle.x - @end.x) * dy - (@inHandle.y - @end.y) * dx)
    if( (d2 + d3) * (d2 + d3) <=  tolerance * ( dx * dx + dy * dy) )
      true
    else
      false

  flattenIntoArray: (points) ->
    if @isFlatWithTolerance(@kDefaultFlatness)
      if points.length == 0
        points.push @start
      points.push @end
    else
#     recursive case
      left = new BrushesViewer.Models.BezierSegment()
      right = new BrushesViewer.Models.BezierSegment()
      @_splitAtT( 0.5, left, right )
      left.flattenIntoArray(points)
      right.flattenIntoArray(points)

  _splitAtT: (t, left, right) ->
    a = @start.add( @outHandle.subtract(@start).multiplyByScaler(t) )
    b = @outHandle.add( @inHandle.subtract(@outHandle).multiplyByScaler(t) )
    c = @inHandle.add( @end.subtract(@inHandle).multiplyByScaler(t) )
    d = a.add(b.subtract(a).multiplyByScaler(t))
    e = b.add(c.subtract(b).multiplyByScaler(t))
    f = d.add(e.subtract(d).multiplyByScaler(t))
    if left
      left.start = @start
      left.outHandle = a
      left.inHandle = d
      left.end = f
    if right
      right.start = f
      right.outHandle = e
      right.inHandle = c
      right.end = @end
    if( (left || right) && @start.isEqual(@outHandle) && @inHandle.isEqual(@end) )
      if left
        left.inHandle = left.end
      if right
        right.outHandle = right.start
    return f
