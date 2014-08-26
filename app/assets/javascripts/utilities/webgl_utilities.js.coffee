pointApplyAffineTransform = (point, transform) ->
  x: (transform.a * point.x + transform.c * point.y + transform.tx)
  y: (transform.b * point.x + transform.d * point.y + transform.ty)

pointMake = (x,y) ->
  {x: x, y: y}

window.rectMake = (x,y,w,h) ->
  origin: {x: x, y: y}
  size: {width: w, height: h}

rectMaxX = (rect) ->
  x1 = rect.origin.x
  x2 = x1 + rect.size.width
  if (x1 >= x2)
    x1
  else
    x2

rectMinX = (rect) ->
  x1 = rect.origin.x
  x2 = x1 + rect.size.width
  if (x1 <= x2)
    x1
  else
    x2

rectMaxY = (rect) ->
  y1 = rect.origin.y
  y2 = y1 + rect.size.height
  if (y1 >= y2)
    y1
  else
    y2

rectMinY = (rect) ->
  y1 = rect.origin.y
  y2 = y1 + rect.size.height
  if (y1 <= y2)
    y1
  else
    y2

window.bindQuadBuffer = (rect, transform) ->
  corners = [
    rect.origin,
    pointMake( rectMaxX(rect), rectMinY(rect)),
    pointMake( rectMaxX(rect), rectMaxY(rect)),
    pointMake( rectMinX(rect), rectMaxY(rect))
  ]

  for corner,i in corners
    corner[i] = pointApplyAffineTransform corner, transform

  arrayBuffer = new Float32Array( corners.length * 4 )
  arrayBuffer.set([corners[0].x, corners[0].y, 0.0, 0.0], 0)
  arrayBuffer.set([corners[1].x, corners[1].y, 0.0, 0.0], 4)
  arrayBuffer.set([corners[3].x, corners[3].y, 0.0, 0.0], 8)
  arrayBuffer.set([corners[2].x, corners[2].y, 0.0, 0.0], 12)

  gl = BrushesViewer.gl
  vertexBuffer = gl.createBuffer();
  console.log('Failed to create the buffer object') if (!vertexBuffer)

  # Bind the buffer object to target
  gl.bindBuffer gl.ARRAY_BUFFER, vertexBuffer

  # Write date into the buffer object
  gl.bufferData gl.ARRAY_BUFFER, arrayBuffer, gl.STATIC_DRAW

  inPosition = gl.getAttribLocation(gl.program, "inPosition")
  console.log "Failed to get the storage location"  if inPosition < 0
  gl.vertexAttribPointer inPosition, 2, gl.FLOAT, false, 16, 0
  gl.enableVertexAttribArray inPosition

window.mat4f_LoadOrtho = (left, right, bottom, top, near, far) ->
  r_l = right - left;
  t_b = top - bottom;
  f_n = far - near;
  tx = - (right + left) / (right - left);
  ty = - (top + bottom) / (top - bottom);
  tz = - (far + near) / (far - near);

  mout = []
  mout[0] = 2.0 / r_l
  mout[1] = 0.0
  mout[2] = 0.0
  mout[3] = 0.0

  mout[4] = 0.0
  mout[5] = 2.0 / t_b
  mout[6] = 0.0
  mout[7] = 0.0

  mout[8] = 0.0
  mout[9] = 0.0
  mout[10] = -2.0 / f_n
  mout[11] = 0.0

  mout[12] = tx
  mout[13] = ty
  mout[14] = tz
  mout[15] = 1.0
  mout

window.affineTransform = (point, t) ->
  p = {}
  p.x = t.a * point.x + t.c * point.y + t.tx
  p.y = t.b * point.x + t.d * point.y + t.ty
