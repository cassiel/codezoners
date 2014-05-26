Foo = ->
  stack = []
  now = Date()
  a: 1
  b: 2
  f: (x) ->
    x * x

  lookAtStack: ->
    stack.slice 0

  lookAtDate: ->
    now
Goo = (x) ->
  myX = x
  @myXFn = ->
    myX

  @myDate = Date()
  return
Goo2 = (x) ->
  fooble = 33
  myX: x
  myDate: Date()
history = []
stack = [
  1
  2
  3
  4
]
history
history.push stack
stack.push 999
stack
history[0] is stack
eqArray history[0], stack
stack
history[0] = [
  1
  2
  3
  4
  999
]
[
  1
  2
  3
  4
]
Foo().lookAtStack()
Foo().f 45
x = Foo()
y = Foo()
x.lookAtDate()
y.lookAtDate()
x2 = new Goo(45)
bogus = Goo(45)
myXFn
x3 = Goo2(90)
x2
x3
x2.myXFn()
x2 = new Goo([
  1
  2
  3
  4
])
x2.myXFn()
x2.myXFn()[2] = 99
x2.myXFn()
