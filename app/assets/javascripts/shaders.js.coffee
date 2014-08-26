BrushesViewer.Shaders.simple_vertex = "
attribute vec4 inPosition;

uniform mat4 modelViewProjectionMatrix;
uniform vec4 color;

varying vec4 colorVarying;

void main()
{
	gl_Position = modelViewProjectionMatrix * inPosition;
	colorVarying = color;
}
"

BrushesViewer.Shaders.simple_fragment = "
precision highp float;
varying vec4 colorVarying;

void main()
{
	gl_FragColor = colorVarying;
}
"

BrushesViewer.Shaders.blit_vertex = "
precision highp float;
uniform mat4 modelViewProjectionMatrix;
attribute vec4 inPosition;  
attribute vec2 inTexcoord;
varying vec2 varTexcoord;

void main (void)
{
	gl_Position	= modelViewProjectionMatrix * inPosition;
  varTexcoord = inTexcoord;
}
"
BrushesViewer.Shaders.blit_with_mask_fragment = "
precision highp float;
varying vec2 varTexcoord;
uniform sampler2D texture;
uniform sampler2D mask;
uniform float opacity;
uniform vec4 color;
uniform bool lockAlpha;
void main (void)
{
    vec4 dst = texture2D(texture, varTexcoord.st, 0.0);
    float srcAlpha = color.a * texture2D(mask, varTexcoord.st, 0.0).a;
    float outAlpha = srcAlpha + dst.a * (1.0 - srcAlpha);
    gl_FragColor.rgb = (color.rgb * srcAlpha + dst.rgb * dst.a * (1.0 - srcAlpha)) / outAlpha;
    gl_FragColor.a = lockAlpha ? dst.a : outAlpha;
    gl_FragColor.a *= opacity;
    gl_FragColor.rgb *= gl_FragColor.a;
}
"

BrushesViewer.Shaders.brush_vertex = "
precision highp float;
uniform mat4 modelViewProjectionMatrix;
attribute vec4 inPosition;
attribute vec2 inTexcoord;
attribute float alpha;
varying vec2 varTexcoord;
varying float varIntensity;

void main (void)
{
	gl_Position	= modelViewProjectionMatrix * inPosition;
  varTexcoord = inTexcoord;
  varIntensity = alpha;
}
"

BrushesViewer.Shaders.brush_fragment = "
precision highp float;
varying vec2 varTexcoord;
varying float varIntensity;
uniform sampler2D texture;

void main (void)
{
    float f = texture2D(texture, varTexcoord.st, 0.0).a;
    float v = varIntensity * f;

    gl_FragColor = vec4(0, 0, 0, v);
}
"

BrushesViewer.shadersJSON = {
  "blit" : {
    "vertex" : "blit",
    "fragment" : "blit",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity"]
  },

  "nonPremultipliedBlit" : {
    "vertex" : "blit",
    "fragment" : "nonPremultipliedBlit",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity"]
  },

  "straightBlit" : {
    "vertex" : "blit",
    "fragment" : "straightBlit",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture"]
  },

  "unPremultipliedBlit" : {
    "vertex" : "blit",
    "fragment" : "unPremultipliedBlit",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity"]
  },

  "blitWithMask" : {
    "vertex" : "blit",
    "fragment" : "blitWithMask",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity", "mask", "color", "lockAlpha"]
  },

  "compositeWithMask" : {
    "vertex" : "blit",
    "fragment" : "compositeWithMask",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "mask", "color", "lockAlpha"]
  },

  "compositeWithEraseMask" : {
    "vertex" : "blit",
    "fragment" : "compositeWithEraseMask",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "mask", "lockAlpha"]
  },

  "blitWithEraseMask" : {
    "vertex" : "blit",
    "fragment" : "blitWithEraseMask",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity", "mask"]
  },

  "desaturate" : {
    "vertex" : "blit",
    "fragment" : "desaturate",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture"]
  },

  "invert" : {
    "vertex" : "blit",
    "fragment" : "invert",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture"]
  },

  "merge" : {
    "vertex" : "blit",
    "fragment" : "merge",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "bottom", "top", "bottomOpacity", "topOpacity", "blendMode"]
  },

  "colorBalanceBlit" : {
    "vertex" : "blit",
    "fragment" : "colorBalanceBlit",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity", "redShift", "greenShift", "blueShift", "premultiply"]
  },

  "toHueChromaLuma" : {
    "vertex" : "blit",
    "fragment" : "toHueChromaLuma",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture"]
  },

  "blitFromHueChromaLuma" : {
    "vertex" : "blit",
    "fragment" : "blitFromHueChromaLuma",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "opacity", "hueShift", "saturationShift", "brightnessShift", "premultiply"]
  },

  "simple" : {
    "vertex" : "simple",
    "fragment" : "simple",
    "attributes" : ["inPosition"],
    "uniforms" : ["modelViewProjectionMatrix", "color"]
  },

  "brush" : {
    "vertex" : "brush",
    "fragment" : "brush",
    "attributes" : ["inPosition", "inTexcoord", "alpha"],
    "uniforms" : ["modelViewProjectionMatrix", "texture"]
  },

  "fill" : {
    "vertex" : "blit",
    "fragment" : "fill",
    "attributes" : ["inPosition", "inTexcoord"],
    "uniforms" : ["modelViewProjectionMatrix", "texture", "color", "lockAlpha"]
  }
}