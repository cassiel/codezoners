function Calculator(resultLine) {
    var stack = [];

    return {
        digit: function (n) { resultLine.setValue(n); },
        enter: function () { },

        number: function(n) { stack.push(n); return this; },
        add: function() {
            var x = stack.pop();
            var y = stack.pop();
            stack.push(x + y);
            return this;
        },

        result: function() { return stack[stack.length - 1]; }
    };
}
