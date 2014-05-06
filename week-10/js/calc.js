// Reference: http://hp15c.org/RPNHowTo.php

var StateEnum = {INPUTTING: 0,         // Entering the digits of a numerical value
                 RESULT: 1,            // We have a calculated value; new input will stack it
                 ENTERED: 2            // We've just "entered" a value which we can calculate or overwrite
                };

var Ops = {
    "+" : function (x, y) { return x + y; }
};

function Calculator(resultLine) {
    // The stack is in this array as [T, Z, Y, X]: fixed-size.
    var stack = [0, 0, 0, 0];
    var state = StateEnum.INPUTTING;

    var history = [];

    var saveState = function () {
        history.push({state: state, stack: stack.slice(0)});
    };

    var restoreState = function () {
        var x = history.pop();
        stack = x.stack;
        state = x.state;
    };

    var adjust = function () {
        if (stack.length > 4) {
            stack.shift();             // Discard entries above T
        } else if (stack.length < 4) {
            stack.unshift(stack[0]);   // Preserve T if stack shrinks
        }
    };

    return {
        refresh: function () {
            resultLine.setValue(stack);
        },

        digit: function (n) {
            saveState();
            n = parseInt(n);

            if (state == StateEnum.INPUTTING) {
                // Continue entering this value
                stack.push(stack.pop() * 10 + n);
            } else if (state == StateEnum.RESULT) {
                // Preserve calculated value by pushing, start entering a new value
                stack.push(n);
                adjust();
            } else {        // state == StateEnum.ENTERED
                // Start replacing the X (which has just been duplicated to Y)
                stack[stack.length - 1] = n;
            }

            state = StateEnum.INPUTTING;
            this.refresh();
        },

        enter: function () {
            saveState();
            stack.push(stack[stack.length - 1]);
            adjust();
            state = StateEnum.ENTERED;
            this.refresh();
        },

        undo: function () {
            if (history.length > 0) {
                restoreState();
                this.refresh();
            }
        },

        op: function (sym) {
            if (sym == "+") {
                saveState();
                var arg2 = stack.pop();
                var arg1 = stack.pop();
                stack.push(arg1 + arg2);
                adjust();
                state = StateEnum.RESULT;
                this.refresh();
            }
        }
    };
}
