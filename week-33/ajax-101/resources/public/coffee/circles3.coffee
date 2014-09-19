# Version which does a POST and expects the server to generate some CSV.
# (TODO: make this post, and generate, JSON.)

window.onload = ->
        rows = 1
        cols = 1

        svg = d3.select "svg"

        refresh = (numRows, numCols) ->
                d3.csv "/data/"
                        .header "Content-Type", "application/x-www-form-urlencoded"
                        .post ("rows=" + numRows + "&cols=" + numCols), (error, rows) ->
                                circle = svg.selectAll "circle"
                                rows.forEach (row) -> console.log "have read", row
                                c = circle.data rows
                                c.enter().append "circle"
                                        .style "fill", "steelblue"
                                        .attr "cy", (d) -> d.y
                                        .attr "cx", (d) -> d.x
                                        .attr "r",  (d) -> d.r
                                c.exit().remove()

        clickRow = (r) ->
                rows = r
                refresh rows, cols

        clickCol = (c) ->
                cols = c
                refresh rows, cols

        this.clickRow = clickRow
        this.clickCol = clickCol

        refresh rows, cols
