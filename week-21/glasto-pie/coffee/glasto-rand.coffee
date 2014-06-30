window.onload = ->
    width = 960
    height = 500
    radius = Math.min(width, height) / 2

    color = d3.scale.ordinal()
        .range ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]

    arc = d3.svg.arc()
        
    svg = d3.select "body"
        .append "svg"
        .attr "width", width
        .attr "height", height
        .append "g"
        .attr "transform", "translate(#{width / 2 + "," + height / 2})"

    textRotate = (startAngle, endAngle) ->
        averageAngle = (startAngle + endAngle) / 2.0
        if averageAngle > Math.PI
                averageAngle * 180.0 / Math.PI + 90.0
        else
                averageAngle * 180.0 / Math.PI - 90.0

    d3.csv "data/data.csv", (error, data) ->
        data.forEach (d) ->
                d.startAngle = Math.random() * 2.0 * Math.PI
                d.endAngle = d.startAngle + 0.5
                d.outerRadius = radius - 10 - Math.random() * 30
                d.innerRadius = d.outerRadius - 60

        g = svg.selectAll ".arc"
                .data data
                .enter()
                .append "g"
                .attr "class", "arc"

        g.append "path"
                .attr "d", arc
                .style "fill", (d) -> color d.age

        g.append "text"
                .attr "transform", (d) -> """
                        translate(#{arc.centroid d})
                        rotate(#{textRotate d.startAngle, d.endAngle})
                """
                .attr "dy", ".35em"
                .style "text-anchor", "middle"
                .text (d) -> d.age
