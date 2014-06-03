m = require "../src/mult"

describe "A suite", () ->
        it "contains spec with an expectation", () ->
                expect(true).toBe(true)

describe "Testing my multiplier", () ->
        it "two times two", () ->
                for i in [1..10]
                        (expect (m.fns.squared i)).toBe(i * i)
        it "works for very large numbers", () ->
                big = 10
                for i in [1..100]
                        big = big * 10
                console.log big
                (expect (m.fns.squared big)).toBe(big * big)
        it "two cubed", () ->
                (expect (m.fns.cubed 2)).toBe(8)

describe "testing defined", () ->
        it "not defined", () ->
                (expect m.bar).not.toBeDefined()

describe "test my reverser", () ->
        it "reverses a range", ->
                expect(m.fns.reverse [1..10]).toBe [10..1]
