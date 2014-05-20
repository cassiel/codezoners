var history = [];

var stack = [1, 2, 3, 4];

history;



history.push(stack);

stack.push(999);

stack;

history[0] === stack;

eqArray(history[0], stack);

stack;

history[0] = [1, 2, 3, 4, 999];

[1, 2, 3, 4]


function Foo() {
    var stack = [];
    var now = Date();

    return {a: 1,
            b: 2,
            f: function (x) { return x * x; },
            lookAtStack: function () { return stack.slice(0); },
            lookAtDate: function () { return now; }
           };
}

Foo().lookAtStack()


Foo().f(45)

var x = Foo();
var y = Foo();


x.lookAtDate()
y.lookAtDate()


function Goo(x) {
    var myX = x;
    this.myXFn = function () { return myX; };
    this.myDate = Date();
}

function Goo2(x) {
    var fooble = 33;
    return {myX: x,
            myDate: Date()
           };
}


var x2 = new Goo(45);

var bogus = Goo(45);

myXFn




var x3 = Goo2(90);

x2
x3



x2.myXFn();

var x2 = new Goo([1, 2, 3, 4]);

x2.myXFn();

x2.myXFn()[2] = 99;

x2.myXFn();
