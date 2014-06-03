# Make and solve a maze.

m = require "../src/maze"

myMaze =
        left: null
        right: null
        ahead:
                left: null
                right: "TREASURE"

myEmptyMaze =
        ahead: null

myDualMaze =
        left: "TREASURE 1"
        right: "TREASURE 2"

describe "Solve a simple maze", () ->
        it "Solving Empty", () ->
                expect(m.fns.solve myEmptyMaze).toEqual null
        it "Solving", () ->
                expect(m.fns.solve myMaze).toEqual "TREASURE"
        it "Solving Dual", () ->
                expect(m.fns.solve myDualMaze).toEqual "TREASURE 1"
