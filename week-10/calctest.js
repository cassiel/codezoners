// Rudimentary unit testing:

// Testing against the object loaded in the live page:

calc;
calc.digit("9");
calc.enter();

function eqArray(a1, a2) {
    return (a1.length==a2.length && a1.every(function(v,i) { return v === a2[i]; }));
}

// Mocking part of the React framework to test the calculator:

function testUndoAsFirstActionDoesntDoAnything() {
    var mockStack = [];
    var c = Calculator({setValue: function (stack) { mockStack = stack; }});

    c.undo();

    if (eqArray(mockStack, [])) {
        return "testUndoAsFirstActionDoesntDoAnything OK";
    } else {
        return "testUndoAsFirstActionDoesntDoAnything FAIL, encountered " + mockStack;
    }
}

testUndoAsFirstActionDoesntDoAnything()


// Testing an isolated instance of the calculator:

function testTwoDigitsGenerateDoubleDigitXValue() {
    var mockStack = [];
    var c = Calculator({setValue: function (stack) { mockStack = stack; }});

    c.digit("3");
    c.digit("4");

    if (eqArray(mockStack, [0, 0, 0, 34])) {
        return "testTwoDigitsGenerateDoubleDigitXValue OK";
    } else {
        return "testTwoDigitsGenerateDoubleDigitXValue FAIL";
    }
}


testTwoDigitsGenerateDoubleDigitXValue()

function testEnterDuplicatesX() {
    var mockStack = [];
    var c = Calculator({setValue: function (stack) { mockStack = stack; }});

    c.digit("2");
    c.enter();

    if (eqArray(mockStack, [0, 0, 2, 2])) {
        return "testEnterDuplicatesX OK";
    } else {
        return "testEnterDuplicatesX FAIL: expecting [0, 0, 2, 2] encountered " + mockStack;
    }
}

testEnterDuplicatesX()

function testSimpleUndo() {
    var mockStack = [];
    var c = Calculator({setValue: function (stack) { mockStack = stack; }});

    c.digit("2");
    c.digit("5");
    c.undo();

    if (eqArray(mockStack, [0, 0, 0, 2])) {
        return "testUndoEnterIntoDigitMode OK";
    } else {
        return "testUndoEnterIntoDigitMode FAIL: expecting [0, 0, 0, 2] encountered " + mockStack;
    }
}

testSimpleUndo()

function testUndoEnterIntoDigitMode() {
    var mockStack = [];
    var c = Calculator({setValue: function (stack) { mockStack = stack; }});

    c.digit("2");
    c.enter();
    c.undo();
    c.digit("5");

    if (eqArray(mockStack, [0, 0, 0, 25])) {
        return "testUndoEnterIntoDigitMode OK";
    } else {
        return "testUndoEnterIntoDigitMode FAIL: expecting [0, 0, 0, 25] encountered " + mockStack;
    }
}

testUndoEnterIntoDigitMode()
