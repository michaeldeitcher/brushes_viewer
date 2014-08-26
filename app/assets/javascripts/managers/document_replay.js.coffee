class BrushesViewer.Managers.DocumentReplay
  constructor: (@data, @includeUndos, @scale) ->
    @delay = 0
    @history = []
    @restart()
    @loadHistory()

  loadHistory: ->
    history_lines = []
    history_lines.push $.parseJSON(action) for action in @data.split('\n') when action[0] == '{'
    @loadHistoryLine history_line, i  for history_line, i in history_lines

  loadHistoryLine: (history_line, i) ->
    line = BrushesViewer.documentChangeFactory.makeDocumentChange history_line
    if line.data.type == 'WDUndoChange'
      @history.splice i-1, 1
    else
      @history.push line

  restart: ->
    @paused = true
    @changeNumber = 0
    @change = null

  play: ->
    if @paused
      @paused = false
      @startTime = $.now()
      @step()

  step: =>
    return if @paused
    if @change == null
      @change = @nextChange()
      if @change
        @animationStep = 1
        @lastAnimationStep = @change.animationSteps()
        @change.beginAnimation()
      else
        console.log 'Replay finished'
        return @paused = true
    if @animationStep <= @lastAnimationStep
      @change.applyToPaintingAnimated @animationStep++, @lastAnimationStep
    if @animationStep > @lastAnimationStep
      @change.endAnimation
      @change = null
#    @step() unless @paused
    requestAnimationFrame(@step)
#    setTimeout(@step, @delay)

  nextChange: ->
    if @changeNumber < @history.length
      @changeNumber++
      @history[@changeNumber-1]
    else
      null


