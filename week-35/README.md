`-*- mode: markdown; mode: visual-line; mode: adaptive-wrap-prefix; -*-`

# WEEK 35: Weather via AJAX

We want to visualise some information from the OpenWeather API.

We need both an HTTP server (to serve web pages with D3 content to the browser, and to respond to AJAX calls) and an HTTP client (running in the server, to fetch weather data which gets turned into CSV for the AJAX calls). Our `project.clj` file contains the dependencies for the Compojure server, plus the `http-clj` client.

For examples of using the HTTP client, see the examples from Week 26: there's a scratch file called `jsonparsing.clj` where we manually fetch pages from the weather site using the published API. (You'll need to fire up a REPL to try it out using LightTable.)

## Exercises

- Get this project running in its current state. There's a single "map" page which reads from a CSV file.

- Revisit the OpenWeather API. We're interested in the call which shows cities around a particular point (latitude, longitude).

- Look at integrating this API into the server so that it returns a CSV file representing a (rough) map of cities, to be drawn in D3. (This will be `map2`.)

- What's wrong with the map? We need the cities to be evenly spread on the canvas - why isn't this happening? How do we fix it?

- With that fixed: some cities will probably be partially off the edge of the canvas: how do we fix that?

- Is the map now in good proportion? Go to a familiar area (by latitude, longitude): does it look right? If not, why not?

- Create an on-screen form for typing in latitude and longitude figures. How will you deal with errors in the input data?

- Create an on-screen form where you type in the name of a city to get a map centered around that city. How will you deal with errors?
