# Version which does a POST and expects the server to generate some CSV.
# (TODO: make this post, and generate, JSON.)

window.onload = ->
        rows = 1
        cols = 1

        svg = d3.select "svg"

        handleData = (rows) ->
                circle = svg.selectAll "circle"
                c = circle.data rows
                c.enter().append "circle"
                        .style "fill", "steelblue"
                        .attr "cy", (d) -> d.y
                        .attr "cx", (d) -> d.x
                        .attr "r",  (d) -> d.r
                c.exit().remove()

        # We need to factor data handling out because we need to clear down the data
        # before we add a new set. D3 assumes that datapoints always arrive
        # in a consistent order, and since they don't here, it'll attempt
        # to reuse on-screen points which are in the wrong place...

        # (There are probably better, D3-idiomatic ways to do this.)

        refresh = (numRows, numCols) ->
                d3.csv "/data/"
                        .header "Content-Type", "application/x-www-form-urlencoded"
                        .post ("rows=" + numRows + "&cols=" + numCols),
                                (error, rows) ->
                                        handleData []
                                        handleData rows

        clickRow = (r) ->
                rows = r
                refresh rows, cols

        clickCol = (c) ->
                cols = c
                refresh rows, cols

        this.clickRow = clickRow
        this.clickCol = clickCol

        refresh rows, cols
