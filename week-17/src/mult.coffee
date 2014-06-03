squared = (x) -> x * x

cubed = (x) -> x * x * x

reverse = (list) ->
        result = []
        len = list.length
        if len > 0
                for i in [len-1 .. 0]
                        result.push list[i]

        result

exports.fns =
        squared: squared
        cubed: cubed
        reverse: reverse
