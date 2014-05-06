// Reference: http://hp15c.org/RPNHowTo.php

var StateEnum = {INPUTTING: 0,         // Entering the digits of a numerical value
                 RESULT: 1,            // We have a calculated value; new input will stack it
                 ENTERED: 2            // We've just "entered" a value which we can calculate or overwrite
                };

function Calculator(resultLine) {
    // The stack is in this array as [T, Z, Y, X]: fixed-size.
    var stack = [0, 0, 0, 0];
    // We start by inputting a value to X:
    var state = StateEnum.INPUTTING;

    var adjust = function () {
        if (stack.length > 4) {
            stack.shift();
        }

        while (stack.length < 4) {
            stack.unshift(stack[0]);
        }
    };

    return {
        refresh: function () {
            //alert("REFRESH!");
            resultLine.setValue(stack);
        },

        digit: function (n) {
            n = parseInt(n);

            if (state == StateEnum.INPUTTING) {
                stack.push(stack.pop() * 10 + n);
            } else if (state == StateEnum.ENTERED) {
                stack[stack.length - 1] = n;
                state = StateEnum.INPUTTING;
            } else {            // state == StateEnum.RESULT
                stack.push(n);
                state = StateEnum.INPUTTING;
            }

            adjust();         // Exercise: do this better.
            this.refresh();
        },

        enter: function () {
            stack.push(stack[stack.length - 1]);
            state = StateEnum.ENTERED;
            adjust();
            this.refresh();
        },

        op: function (tag) {
            if (tag == "+") {
                var y = stack.pop();
                var x = stack.pop();
                stack.push(x + y);
                adjust();
                state = StateEnum.RESULT;
                this.refresh();
            }
        }
    };
}
