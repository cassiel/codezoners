// Working with Javascript in NodeJS.

function Calculator() {
    this.stack = [];

    this.number = function(n) {
        this.stack.push(n);
    };

    this.add = function() {
        var x = this.stack.pop();
        var y = this.stack.pop();
        this.stack.push(x + y);
    };

    this.times = function() {
        var x = this.stack.pop();
        var y = this.stack.pop();
        this.stack.push(x * y);
    };

    this.divide = function() {
        var y = this.stack.pop();
        var x = this.stack.pop();
        this.stack.push(x / y);
    };

    this.subtract = function() {
        var y = this.stack.pop();
        var x = this.stack.pop();
        this.stack.push(x - y);
    };

    this.dup = function() {
        var x = this.stack.pop();
        this.stack.push(x);
        this.stack.push(x);
    };

    this.result = function() {
      return this.stack[this.stack.length - 1];
    };

    //return this;
}

var c = new Calculator();

// Test 1:
var c = new Calculator();
c.number(200);
c.number(100);
c.subtract();
console.log("expected " + 100 + " actual " + c.result());


var c = new Calculator();
c.number(1);
c.number(2);
console.log("expected " + 2 + " actual " + c.result());
c.result();


c = new Calculator();
c.number(100);
c.dup();
c.times();
console.log("expected " + 10000 + " actual " + c.result());

c.number(100);
c.dup();
c.add();  // 200


// How do we support method chaining?
//c.number(100).number(200).number(3).times().add().result();
// 700?
