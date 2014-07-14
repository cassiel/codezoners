populateStageGroups = (db, rows) ->
        stmt = db.prepare "INSERT OR IGNORE INTO StageGroup (Name) VALUES ($group)"
        rows.forEach (r) ->
                #console.log "Inserting group #{r.group}"
                stmt.bind '$group': r.group
                stmt.run()

populateStages = (db, rows) ->
        stmt = db.prepare """
                INSERT OR IGNORE INTO Stage (Name, StageGroup_ID)
                SELECT $stage AS Name, ID AS StageGroup_ID FROM StageGroup WHERE Name = $group
        """
        rows.forEach (r) ->
                #console.log "Inserting stage #{r.stage}"
                stmt.bind '$stage': r.stage, '$group': r.group
                stmt.run()

populateArtists = (db, rows) ->
        stmtA = db.prepare """
                INSERT OR IGNORE INTO Artist (Name) VALUES ($artist)
        """
        stmtS = db.prepare """
                INSERT OR IGNORE INTO Artists_Stages (Artist_ID, Stage_ID)
                SELECT Artist.ID AS Artist_ID, Stage.ID AS Stage_ID
                  FROM Artist, Stage
                 WHERE Artist.Name = $artist
                   AND Stage.Name = $stage
        """
        rows.forEach (r) ->
                #console.log "Inserting artist #{r.artist}"
                stmtA.bind '$artist': r.artist
                stmtA.run()
                stmtS.bind '$artist': r.artist, '$stage': r.stage
                stmtS.run()

populate = (db, rows) ->
        populateStageGroups db, rows
        populateStages db, rows
        populateArtists db, rows

sql = window.SQL
db = new sql.Database()

# Create tables, with some normalization.

# (We have to make assumptions based on an inspection of the
# data. Each stage only appears in one stage group (many<->one), but
# some artists appear on different stages (many<->many)).

db.run """
        CREATE TABLE StageGroup(ID Integer PRIMARY KEY,
                                Name STRING UNIQUE)
"""
db.run """
        CREATE TABLE Stage(ID Integer PRIMARY KEY,
                           Name STRING UNIQUE,
                           StageGroup_ID Integer REFERENCES StageGroup(ID))
"""
db.run """
        CREATE TABLE Artist(ID Integer PRIMARY KEY,
                            Name STRING UNIQUE)
"""
db.run """
        CREATE TABLE Artists_Stages(Artist_ID Integer REFERENCES Artist(ID),
                                    Stage_ID Integer REFERENCES Stage(ID),
                                    CONSTRAINT X UNIQUE (Artist_ID, Stage_ID))
"""

QUERYx = """
        SELECT a.Name AS Name,
               s.Name AS Stage
          FROM Artist a, Stage s, Artists_Stages ast
         WHERE a.Name LIKE 'TEMPLES'
           AND a.ID = ast.Artist_ID
           AND s.ID = ast.Stage_ID
"""
QUERY = """
        SELECT a.Name AS Name,
               s.Name AS Stage,
               g.Name AS StageGroup
          FROM Artist a, Stage s, StageGroup g, Artists_Stages ast
         WHERE g.Name LIKE '%CIRCUS%'
           AND a.ID = ast.Artist_ID
           AND s.ID = ast.Stage_ID
           AND s.StageGroup_ID = g.ID
"""

window.onload = ->
        width = 960
        height = 500
        radius = Math.min(width, height) / 2

        color = d3.scale.ordinal()
                .range ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]

        # The innerRadius and outerRadius values are now set individually for each arc.
        arc = d3.svg.arc()
        
        svg = d3.select "body"
                .append "svg"
                .attr "width", width
                .attr "height", height
                .append "g"
                .attr "transform", "translate(#{width / 2},#{height / 2})"

        textRotate = (startAngle, endAngle) ->
                averageAngle = ( (startAngle + endAngle) / 2.0 ) % (2.0 * Math.PI)
                if averageAngle > Math.PI
                        averageAngle * 180.0 / Math.PI + 90.0
                else
                        averageAngle * 180.0 / Math.PI - 90.0

        d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
                .row (d) ->
                        # Make the field names more sanitary:
                        artist: d["Artist name"]
                        group: d["Stage group"]
                        stage: d["Stage"]

                .get (error, rows) ->
                        populate db, rows
                        results = []

                        stmt = db.prepare QUERY
                        while stmt.step()
                                results.push(stmt.getAsObject())

                        results.forEach (d) ->
                                # We're still generating random values for angles and radius distances.
                                # (But doing one per data query row.)
                                d.startAngle = Math.random() * 2.0 * Math.PI
                                d.endAngle = d.startAngle + Math.PI / 4.0
                                d.outerRadius = radius - 10 - Math.random() * 30
                                d.innerRadius = d.outerRadius - 60

                        g = svg.selectAll ".arc"
                                .data results
                                .enter()
                                .append "g"
                                .attr "class", "arc"

                        g.append "path"
                                .attr "d", arc
                                # We use the actual database values for 'Name' to drive colours and text.
                                .style "fill", (d) -> color d.Name

                        g.append "text"
                                .attr "transform", (d) -> """
                                        translate(#{arc.centroid d})
                                        rotate(#{textRotate d.startAngle, d.endAngle})
                                """
                                .attr "dy", ".35em"
                                .style "text-anchor", "middle"
                                .text (d) -> d.Name

                        results.forEach (d) ->
                                console.log d
