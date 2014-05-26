# Reference: http://hp15c.org/RPNHowTo.php
# Entering the digits of a numerical value
# We have a calculated value; new input will stack it
# We've just "entered" a value which we can calculate or overwrite
Calculator = (resultLine) ->
  
  # The stack is in this array as [T, Z, Y, X]: fixed-size.
  stack = [
    0
    0
    0
    0
  ]
  state = StateEnum.INPUTTING
  history = []
  saveState = ->
    history.push
      state: state
      stack: stack.slice(0)

    return

  restoreState = ->
    x = history.pop()
    stack = x.stack
    state = x.state
    return

  adjust = ->
    if stack.length > 4
      stack.shift() # Discard entries above T
    else stack.unshift stack[0]  if stack.length < 4 # Preserve T if stack shrinks
    return

  refresh: ->
    resultLine.setValue stack
    return

  digit: (n) ->
    saveState()
    n = parseInt(n)
    if state is StateEnum.INPUTTING
      
      # Continue entering this value
      stack.push stack.pop() * 10 + n
    else if state is StateEnum.RESULT
      
      # Preserve calculated value by pushing, start entering a new value
      stack.push n
      adjust()
    else # state == StateEnum.ENTERED
      # Start replacing the X (which has just been duplicated to Y)
      stack[stack.length - 1] = n
    state = StateEnum.INPUTTING
    @refresh()
    return

  enter: ->
    saveState()
    stack.push stack[stack.length - 1]
    adjust()
    state = StateEnum.ENTERED
    @refresh()
    return

  undo: ->
    if history.length > 0
      restoreState()
      @refresh()
    return

  op: (sym) ->
    if sym is "+"
      saveState()
      arg2 = stack.pop()
      arg1 = stack.pop()
      stack.push arg1 + arg2
      adjust()
      state = StateEnum.RESULT
      @refresh()
    return
StateEnum =
  INPUTTING: 0
  RESULT: 1
  ENTERED: 2

Ops = "+": (x, y) ->
  x + y

exports.Calculator = Calculator  if typeof (exports) isnt "undefined"
