# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  paper.install window #install paper.js to the global scope
  BrushesViewer.documentChangeFactory = new BrushesViewer.DocumentUpdates.DocumentChangeFactory()

# simple_painting
#  paintingFileJSON = {"history":{"type":"data","encoding":"binary","content-type":"application/json","src":"history.json"},"image":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"image.jpg"},"painting":{"type":"WDPainting","activeLayer":0,"dimensions":{"type":"size","w":768,"h":1024},"strokeCount":7,"uuid":"H47iXL6JT128kmFnFpgGRw","changeCount":9,"layers":[{"type":"WDLayer","visible":true,"locked":false,"alphaLocked":false,"blendMode":1852797549,"uuid":"W0zLjX5tS3+mh7CnZyfEDA","layerImage":{"type":"data","encoding":"binary","content-type":"image/x-brushes-layer","src":"W0zLjX5tS3+mh7CnZyfEDA"}}],"imageDatas":{},"brushes":{"type":"NSCountedSet","objects":[{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"LrD8DCQeSTWPP24zCtOhgQ","weight":17,"intensity":1,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},7]},"colors":{"type":"NSCountedSet","objects":[{"type":"WDColor","h":0.422098,"s":0.105691,"b":0.195122,"a":1},7]},"undoneBrushes":[]},"thumbnail":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"thumbnail.jpg"}}
# square
#  paintingFileJSON = {"history":{"type":"data","encoding":"binary","content-type":"application/json","src":"history.json"},"image":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"image.jpg"},"painting":{"type":"WDPainting","activeLayer":0,"dimensions":{"type":"size","w":768,"h":1024},"strokeCount":1,"uuid":"sIELcpacSlWImtnnlFQWew","changeCount":3,"layers":[{"type":"WDLayer","visible":true,"locked":false,"alphaLocked":false,"blendMode":1852797549,"uuid":"cekezm5UTAO9wH1z5+kAIw","layerImage":{"type":"data","encoding":"binary","content-type":"image/x-brushes-layer","src":"cekezm5UTAO9wH1z5+kAIw"}}],"imageDatas":{},"brushes":{"type":"NSCountedSet","objects":[{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"3sglJKhnTOadvs7LacEaDg","weight":200,"intensity":0.304545,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},true]},"colors":{"type":"NSCountedSet","objects":[{"type":"WDColor","h":0,"s":0,"b":0,"a":1},true]},"undoneBrushes":[]},"thumbnail":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"thumbnail.jpg"}}
# outline
  paintingFileJSON = {"history":{"type":"data","encoding":"binary","content-type":"application/json","src":"history.json"},"image":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"image.jpg"},"painting":{"type":"WDPainting","activeLayer":0,"dimensions":{"type":"size","w":768,"h":1024},"strokeCount":6,"uuid":"vcQSHNPhT06nnIMO5sdKeg","changeCount":10,"layers":[{"type":"WDLayer","visible":true,"locked":false,"alphaLocked":false,"blendMode":1852797549,"uuid":"RSFNP80BRVe1V1ziD1ciJg","layerImage":{"type":"data","encoding":"binary","content-type":"image/x-brushes-layer","src":"RSFNP80BRVe1V1ziD1ciJg"}}],"imageDatas":{},"brushes":{"type":"NSCountedSet","objects":[{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"UxuFcXSISsqoTP9elpjknQ","weight":10,"intensity":0.304545,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},true,{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"UXnr37c7R3ez8fWC9p+ITQ","weight":23,"intensity":0.304545,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},5]},"colors":{"type":"NSCountedSet","objects":[{"type":"WDColor","h":0,"s":0,"b":0,"a":1},6]},"undoneBrushes":[]},"thumbnail":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"thumbnail.jpg"}}
# infinity
#  paintingFileJSON = {"history":{"type":"data","encoding":"binary","content-type":"application/json","src":"history.json"},"image":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"image.jpg"},"painting":{"type":"WDPainting","activeLayer":0,"dimensions":{"type":"size","w":768,"h":1024},"strokeCount":7,"uuid":"H47iXL6JT128kmFnFpgGRw","changeCount":9,"layers":[{"type":"WDLayer","visible":true,"locked":false,"alphaLocked":false,"blendMode":1852797549,"uuid":"W0zLjX5tS3+mh7CnZyfEDA","layerImage":{"type":"data","encoding":"binary","content-type":"image/x-brushes-layer","src":"W0zLjX5tS3+mh7CnZyfEDA"}}],"imageDatas":{},"brushes":{"type":"NSCountedSet","objects":[{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"LrD8DCQeSTWPP24zCtOhgQ","weight":17,"intensity":1,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},7]},"colors":{"type":"NSCountedSet","objects":[{"type":"WDColor","h":0.422098,"s":0.105691,"b":0.195122,"a":1},7]},"undoneBrushes":[]},"thumbnail":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"thumbnail.jpg"}}
#
# line
#  paintingFileJSON = {"history":{"type":"data","encoding":"binary","content-type":"application/json","src":"history.json"},"image":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"image.jpg"},"painting":{"type":"WDPainting","activeLayer":0,"dimensions":{"type":"size","w":768,"h":1024},"strokeCount":1,"uuid":"iG9ykjzGTd68D9bek3ijUw","changeCount":3,"layers":[{"type":"WDLayer","visible":true,"locked":false,"alphaLocked":false,"blendMode":1852797549,"uuid":"YYBg0GP3STKlvQY9j+n9fw","layerImage":{"type":"data","encoding":"binary","content-type":"image/x-brushes-layer","src":"YYBg0GP3STKlvQY9j+n9fw"}}],"imageDatas":{},"brushes":{"type":"NSCountedSet","objects":[{"type":"WDBrush","generator":{"type":"WDRectGenerator","seed":323982985,"size":{"type":"size","w":512,"h":512},"blurRadius":5,"width":1},"uuid":"SzaESbuRT5eGalV6Wh30iQ","weight":2,"intensity":0.304545,"angle":0,"spacing":0.004,"rotationalScatter":0,"positionalScatter":0,"angleDynamics":0,"weightDynamics":0,"intensityDynamics":0},true]},"colors":{"type":"NSCountedSet","objects":[{"type":"WDColor","h":0,"s":0,"b":0,"a":1},true]},"undoneBrushes":[]},"thumbnail":{"type":"data","encoding":"binary","content-type":"image/jpeg","src":"thumbnail.jpg"}}

  reader = new FileReader()
  playHistory = ->
    BrushesViewer.painting = new BrushesViewer.Models.Painting(paintingFileJSON.painting)
    BrushesViewer.documentReplay = new BrushesViewer.Managers.DocumentReplay reader.result, true, 1.0
    BrushesViewer.documentReplay.play()
    $('button#replay').show()

  $('#picture').change (e) =>
    reader.onerror = (e) =>
      alert "An error occurred reading this file."
    reader.onload = (e) =>
      console.log $.parseJSON reader.result
    reader.readAsText e.target.files[0]
  $('#history').change (e) =>
    reader.onerror = (e) =>
      alert "An error occurred reading this file."
    reader.onload = (e) =>
      playHistory()
    reader.readAsText e.target.files[0]
  $('button#replay').click =>
    playHistory()

