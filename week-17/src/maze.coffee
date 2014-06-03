solve = (m) ->
        keys = Object.keys m
        for key in keys
                if m[key] == null
                        return null
                else if typeof m[key] == 'object'
                        return solve m[key]
                else if typeof m[key] == 'string'
                        return m[key]

exports.fns =
        solve: solve
