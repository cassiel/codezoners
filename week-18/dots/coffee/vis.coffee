window.onload = ->
        vis = d3.select "#graph"
        svg = vis.append "svg"

        svg.attr("width", 300).attr("height", 300)

        # Data sequence for circle set:
        # theData = ({X: n * 10, Y: n * 10} for n in [1..30])
        theData = (({X: 37.5 + x * 75, Y: 37.5 + y * 75} for x in [0..3]) \
          for y in [0..3]).reduce((a, b) -> a.concat b)

        # Bind circle selection in the SVG to the data:
        circle = svg.selectAll("circle").data theData

        # Entry for new circles created as data is added:
        enter = circle.enter().append "circle"

        # Attribute constants and values for the circles
        enter.attr "cy", (d) -> d.Y
        enter.attr "cx", (d) -> d.X
        enter.attr "r", 20
        enter.attr "fill", (_) -> "rgb(#{Math.floor(Math.random() * 255)}, 0, 0)"
