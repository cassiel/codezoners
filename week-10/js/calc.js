// Reference: http://hp15c.org/RPNHowTo.php

var StateEnum = {
    INPUTTING: 0,
    RESULT: 1,
    ENTERED: 2
};

// Digit entry:
//   - in the middle of entering a number
//   - having just calculated a result
//   - having just typed ENTER

function Calculator(resultLine) {
    // The stack is in this array as [T, Z, Y, X]: fixed-size.
    var stack = [0, 0, 0, 0];
    var state = StateEnum.INPUTTING;

    var adjust = function () {
        if (stack.length > 4) {
            stack.shift();             // Discard entries above T
        } else if (stack.length < 4) {
            stack.unshift(stack[0]);   // Preserve T if stack shrinks
        }
    };

    return {
        stack: stack,

        refresh: function () {
            resultLine.setValue(stack);
        },

        digit: function (n) {
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
            stack.push(stack[stack.length - 1]);
            adjust();
            state = StateEnum.ENTERED;
            this.refresh();
        },

        undo: function () { },

        op: function (sym) {
            if (sym == "+") {
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
