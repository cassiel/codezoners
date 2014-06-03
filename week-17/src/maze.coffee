solve = (m) ->
        keys = Object.keys m
        for key in keys
                if m[key] != null
                        if typeof m[key] == 'object'
                                candidate = solve m[key]
                                if candidate
                                        return candidate
                        else if typeof m[key] == 'string'
                                return m[key]

exports.fns =
        solve: solve
