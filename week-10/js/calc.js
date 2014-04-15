function Calculator() {
    var stack = [];

    return {
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

var c = Calculator();
c.number(13).number(100).add().result();
c.result();

c
