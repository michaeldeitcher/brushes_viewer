class BrushesViewer.Models.Brush
  constructor: (@data) ->
    @generator = new BrushesViewer.Models.StampGenerator(@data.generator)
    @weight = @data.weight
    @spacing = @data.spacing
    @intensity = @data.intensity

#{"type":"WDBrush",
# "generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},
# "uuid":"LrD8DCQeSTWPP24zCtOhgQ",
# "weight":17,"intensity":1,"angle":0,"spacing":0.004,
# "rotationalScatter":0,"positionalScatter":0,
# "angleDynamics":0,"weightDynamics":0,"intensityDynamics":0}