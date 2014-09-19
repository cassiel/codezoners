# Version which does a plain GET to fetch a static file.

window.onload = ->
        svg = d3.select "svg"
        circle = svg.selectAll "circle"

        d3.csv "/my-data.csv"
                .get (error, rows) ->
                        rows.forEach (row) -> console.log "have read", row
                        c = circle.data rows
                        c.enter().append "circle"
                                .style "fill", "steelblue"
                                .attr "cy", (d) -> d.y
                                .attr "cx", (d) -> d.x
                                .attr "r",  (d) -> d.r
                        c.exit().remove()
