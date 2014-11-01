# Working with Javascript in NodeJS.
Calculator = ->
  @stack = []
  @number = (n) ->
    @stack.push n
    return

  @add = ->
    x = @stack.pop()
    y = @stack.pop()
    @stack.push x + y
    return

  @times = ->
    x = @stack.pop()
    y = @stack.pop()
    @stack.push x * y
    return

  @divide = ->
    y = @stack.pop()
    x = @stack.pop()
    @stack.push x / y
    return

  @subtract = ->
    y = @stack.pop()
    x = @stack.pop()
    @stack.push x - y
    return

  @dup = ->
    x = @stack.pop()
    @stack.push x
    @stack.push x
    return

  @result = ->
    @stack[@stack.length - 1]

  return

#return this;
c = new Calculator()

# Test 1:
c = new Calculator()
c.number 200
c.number 100
c.subtract()
console.log "expected " + 100 + " actual " + c.result()
c = new Calculator()
c.number 1
c.number 2
console.log "expected " + 2 + " actual " + c.result()
c.result()
c = new Calculator()
c.number 100
c.dup()
c.times()
console.log "expected " + 10000 + " actual " + c.result()
c.number 100
c.dup()
c.add() # 200

# How do we support method chaining?
#c.number(100).number(200).number(3).times().add().result();
# 700?