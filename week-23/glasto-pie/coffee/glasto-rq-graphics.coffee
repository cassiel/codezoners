define ["glasto-rq-data"], (data) ->
        onload: ->
                data.withResults (results) ->
                        width = 960
                        height = 500
                        radius = Math.min(width, height) / 2

                        color = d3.scale.ordinal()
                            .range ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]

                        textRotate = (startAngle, endAngle) ->
                            averageAngle = ( (startAngle + endAngle) / 2.0 ) % (2.0 * Math.PI)
                            if averageAngle > Math.PI
                                    averageAngle * 180.0 / Math.PI + 90.0
                            else
                                    averageAngle * 180.0 / Math.PI - 90.0

                        # The innerRadius and outerRadius values are now set individually for each arc.
                        arc = d3.svg.arc()

                        svg = d3.select "body"
                            .append "svg"
                            .attr "width", width
                            .attr "height", height
                            .append "g"
                            .attr "transform", "translate(#{width / 2},#{height / 2})"

                        g = svg.selectAll ".arc"
                                .data results
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

                        results.forEach (d) -> console.log d
