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
                INSERT OR IGNORE INTO Appearance (Artist_ID, Stage_ID, StartTime, EndTime)
                SELECT Artist.ID AS Artist_ID,
                       Stage.ID AS Stage_ID,
                       DateTime($startTime),
                       DateTime($endTime)
                  FROM Artist, Stage
                 WHERE Artist.Name = $artist
                   AND Stage.Name = $stage
        """
        rows.forEach (r) ->
                #console.log "Inserting artist #{r.artist}"
                stmtA.bind '$artist': r.artist
                stmtA.run()
                stmtS.bind
                        '$artist': r.artist
                        '$stage': r.stage
                        '$startTime': r.startTimeStr
                        '$endTime': r.endTimeStr
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
        CREATE TABLE Appearance(Artist_ID Integer REFERENCES Artist(ID),
                                Stage_ID Integer REFERENCES Stage(ID),
                                StartTime DateTime NOT NULL,
                                EndTime DateTime NOT NULL)
"""
# Expect the strftime() calculations here to fail in Winter! I expect
# they're treating the strings from the CSV as the local time zone seen
# by the database engine.

# As will be clear from the visualisation, this query doesn't understand
# shows will run over the midnight boundary (of which there are many). I
# leave that as a exercise.
QUERY = """
        SELECT a.Name AS Name,
               s.Name AS Stage,
               s.ID AS StageID,
               g.Name AS StageGroup,
               (strftime('%s', ap.StartTime) % (60 * 60 * 24 * 1.0)) / (60 * 60 * 24) AS startTime,
               (strftime('%s', ap.EndTime) % (60 * 60 * 24 * 1.0)) / (60 * 60 * 24) AS endTime
          FROM Artist a, Stage s, StageGroup g, Appearance ap
         WHERE a.ID = ap.Artist_ID
           AND s.ID = ap.Stage_ID
           AND s.StageGroup_ID = g.ID
           ORDER BY s.ID ASC
"""

# These aren't used yet: we need to turn the day names and times in the
# CSV file into date-time values so that we can query and filter the
# output by date.

dayToDateMap =
        "WEDNESDAY" : "2014-06-25"
        "THURSDAY"  : "2014-06-26"
        "FRIDAY"    : "2014-06-27"
        "SATURDAY"  : "2014-06-28"
        "SUNDAY"    : "2014-06-29"

define () ->
        # This is a bit of design smell, uncovered by the Require restructuring: geometry
        # declarations in the data generation. So, no longer needed - we normalise the
        # values instead.

        #width = 960
        #height = 500
        #radius = Math.min(width, height) / 2

        results = []

        # This won't work: we're not in the callback (even if we call d3.csv right here):
        results: results

        # Thsi will work: return a function which calls a callback:
        withResults: (f) ->
                d3.csv "data/Glastonbury 2014 - official timings - Line-up.csv"
                        .row (d) ->
                                # Make the field names more sanitary:
                                artist: d["Artist name"]
                                group: d["Stage group"]
                                stage: d["Stage"]
                                # Many of the data rows contain incorrectly-formatted (or missing)
                                # time fields. Exercise: determine what's happening to these.
                                startTimeStr: d["Start time"]
                                endTimeStr: d["End time"]

                        .get (error, rows) ->
                                populate db, rows

                                stmt = db.prepare QUERY
                                while stmt.step()
                                        results.push(stmt.getAsObject())

                                results.forEach (d) ->
                                        # Normalise these so that we don't tie ourselves to the geometry:
                                        d.startPosition = d.startTime
                                        d.endPosition = d.endTime
                                        d.radius = d.StageID / 100.0

                                f results
