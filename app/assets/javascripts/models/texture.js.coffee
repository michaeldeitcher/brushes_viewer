class BrushesViewer.Models.Texture
  constructor: (imageSrc)->
    gl = BrushesViewer.gl
    @textureName = gl.createTexture()
    gl.bindTexture(gl.TEXTURE_2D, @textureName)
    image = new Image() # Create the image object
    image.src = imageSrc
    @assignImageToTexture(image)

  assignImageToTexture: (image) ->
    gl = BrushesViewer.gl
    gl.bindTexture(gl.TEXTURE_2D, @textureName)
    gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGB, gl.RGB, gl.UNSIGNED_BYTE, image)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST)
    gl.generateMipmap(gl.TEXTURE_2D)
