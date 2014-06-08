window.onload = ->
        vis = d3.select "#graph"
        svg = vis.append "svg"

        svg.attr("width", 300).attr("height", 300)

        circle = svg.selectAll("circle").data [32, 57, 112, 193]

        enter = circle.enter().append "circle"

        enter.attr "cy", (d) -> d
        enter.attr "cx", (d) -> d
        enter.attr "r", (d) -> Math.sqrt d
