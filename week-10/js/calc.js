// Reference: http://hp15c.org/RPNHowTo.php

function Calculator(resultLine) {
    // The stack is in this array as [T, Z, Y, X]: fixed-size.
    var stack = [0, 0, 0, 0];

    return {
        refresh: function () {
        },

        digit: function (n) {
        },

        enter: function () {
        },

        op: function (tag) {
        }
    };
}

// Advanced: T is preserved on pop. Implement a stack object.
