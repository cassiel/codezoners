# Rudimentary unit testing:
eqArray = (a1, a2) ->
  a1.length is a2.length and a1.every((v, i) ->
    v is a2[i]
  )

# Mocking part of the React framework to test the calculator:
testUndoAsFirstActionDoesntDoAnything = ->
  mockStack = []
  c = calc.Calculator(setValue: (stack) ->
    mockStack = stack
    return
  )
  c.undo()
  if eqArray(mockStack, [])
    "testUndoAsFirstActionDoesntDoAnything OK"
  else
    "testUndoAsFirstActionDoesntDoAnything FAIL, encountered " + mockStack

# Testing an isolated instance of the calculator:
testTwoDigitsGenerateDoubleDigitXValue = ->
  mockStack = []
  c = calc.Calculator(setValue: (stack) ->
    mockStack = stack
    return
  )
  c.digit "3"
  c.digit "4"
  if eqArray(mockStack, [
    0
    0
    0
    34
  ])
    "testTwoDigitsGenerateDoubleDigitXValue OK"
  else
    "testTwoDigitsGenerateDoubleDigitXValue FAIL"
testEnterDuplicatesX = ->
  mockStack = []
  c = calc.Calculator(setValue: (stack) ->
    mockStack = stack
    return
  )
  c.digit "2"
  c.enter()
  if eqArray(mockStack, [
    0
    0
    2
    2
  ])
    "testEnterDuplicatesX OK"
  else
    "testEnterDuplicatesX FAIL: expecting [0, 0, 2, 2] encountered " + mockStack
testSimpleUndo = ->
  mockStack = []
  c = calc.Calculator(setValue: (stack) ->
    mockStack = stack
    return
  )
  c.digit "2"
  c.digit "5"
  c.undo()
  if eqArray(mockStack, [
    0
    0
    0
    2
  ])
    "testUndoEnterIntoDigitMode OK"
  else
    "testUndoEnterIntoDigitMode FAIL: expecting [0, 0, 0, 2] encountered " + mockStack
testUndoEnterIntoDigitMode = ->
  mockStack = []
  c = calc.Calculator(setValue: (stack) ->
    mockStack = stack
    return
  )
  c.digit "2"
  c.enter()
  c.undo()
  c.digit "5"
  if eqArray(mockStack, [
    0
    0
    0
    25
  ])
    "testUndoEnterIntoDigitMode OK"
  else
    "testUndoEnterIntoDigitMode FAIL: expecting [0, 0, 0, 25] encountered " + mockStack
calc = require("./js/calc.js")
console.log testUndoAsFirstActionDoesntDoAnything()
console.log testTwoDigitsGenerateDoubleDigitXValue()
console.log testEnterDuplicatesX()
console.log testSimpleUndo()
console.log testUndoEnterIntoDigitMode()
