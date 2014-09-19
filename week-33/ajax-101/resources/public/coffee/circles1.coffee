# Cargo-culted from http://bost.ocks.org/mike/circles/

window.onload = ->
        svg = d3.select "svg"
        circle = svg.selectAll "circle"
                .data [32, 57, 293, 500]

        circle.enter().append "circle"
                .style "fill", "steelblue"
                .attr "cy", 60
                .attr "cx", (d, i) -> i * 100 + 30
                .attr "r", (d) -> Math.sqrt d

        circle.exit().remove()
