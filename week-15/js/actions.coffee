$(document).ready ->
  $(".num").click ->
    calc.digit @textContent
    return

  $(".op").click ->
    calc.op @textContent
    return

  $(".enter").click ->
    calc.enter()
    return

  return

