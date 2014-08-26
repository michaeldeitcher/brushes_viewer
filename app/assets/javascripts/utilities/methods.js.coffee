BrushesViewer.Utilities.ab2str = (buf) ->
  String.fromCharCode.apply null, new Uint16Array(buf)

BrushesViewer.Utilities.str2ab = (str) ->
  buf = new ArrayBuffer(str.length * 2) # 2 bytes for each char
  bufView = new Uint16Array(buf)
  i = 0
  strLen = str.length

  while i < strLen
    bufView[i] = str.charCodeAt(i)
    i++
  buf

BrushesViewer.Utilities.Distance = (a, b) ->
  xd = a.x - b.x
  yd = a.y - b.y
  Math.sqrt(xd * xd + yd * yd)