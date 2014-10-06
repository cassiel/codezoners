# Version which does a plain GET to fetch a static file.

window.onload = ->
        svg = d3.select "svg"
        circle = svg.selectAll "circle"
        text = svg.selectAll "text"

        d3.csv "/my-data.csv"
                .get (error, rows) ->
                        c = circle.data rows
                        c.enter().append "circle"
                                .style "fill", "steelblue"
                                .attr "cy", (d) -> d.y
                                .attr "cx", (d) -> d.x
                                .attr "r",  (d) -> d.r
                        c.exit().remove()

                        # Slight distraction: rotate and style the text
                        # Text: http://tutorials.jenkov.com/svg/text-element.html
                        # Transformations: http://tutorials.jenkov.com/svg/svg-transformation.html
                        t = text.data rows
                        t.enter().append "text"
                                .attr "x", (d) -> d.x
                                .attr "y", (d) -> d.y
                                .style "font-family", "Optima"
                                .style "text-anchor", "middle"
                                .attr "transform", (d) -> "rotate(-30, #{d.x}, #{d.y})"
                                .text (d) -> d.name
                        t.exit().remove()
