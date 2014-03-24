this.outlets = 16;
this.inlets = 1;

/* const */ var BOARD_SIZE = 16;

var cells = [];
// Numbering cells/tiles from 1:
for (var i = 1; i < BOARD_SIZE; i++) {
	cells.push(i);
}
cells.push(".");


function flush() {
	for (var i = 0; i < cells.length; i++) {
		outlet(i, "set", cells[i]);
	}
}

function shuffle() {
	for (var i = 0; i < cells.length; i++) {
		var index = Math.floor(Math.random() * cells.length);

		var tmp = cells[i];
		cells[i] = cells[index];
		cells[index] = tmp;
	}

	flush();
}

// This is James's solution for determining whether a clicked tile can be moved:
function adjacent(dotLocation, clickedLocation) {
	var dotX = dotLocation % 4;
	var dotY = Math.floor(dotLocation / 4);

	var clickedX = clickedLocation % 4;
	var clickedY = Math.floor(clickedLocation / 4);

	if (Math.abs(dotX - clickedX) == 1
	    && dotY == clickedY) {
		return true;
	} else if (Math.abs(dotY - clickedY) == 1
	    	   && dotX == clickedX) {
		return true;
	} else {
		return false;
	}
}

function click(tileNum) {
	var dotLocation = cells.indexOf(".");
	var clickedLocation = cells.indexOf(tileNum);

	var adj = adjacent(dotLocation, clickedLocation);

	if (adj) {
		var tmp = cells[dotLocation];
		cells[dotLocation] = cells[clickedLocation];
		cells[clickedLocation] = tmp;
		flush();
	}

	post("adjacent?", adj);
	post();
}

// This is Nick's solution:
function posFromCoords(x, y) {
    return y * 4 + x;
}

// Return array of indices orthogonally adjacent
// to pos (which is zero-based).
function adjacentIndices(pos) {
    var x = pos % 4;
    var y = Math.floor(pos / 4);
    var result = [];

    if (x > 0) { result.push(posFromCoords(x - 1, y)); }
    if (x < 3) { result.push(posFromCoords(x + 1, y)); }
    if (y > 0) { result.push(posFromCoords(x, y - 1)); }
    if (y < 3) { result.push(posFromCoords(x, y + 1)); }

    return result;
}

// Click on a tile:

function click2(x) {
    if (x != ".") {
        // Can we move this tile to the space? Easiest test: is it adjacent
        // to the blank?
        var pos = cells.indexOf(x);
        var adjacents = adjacentIndices(pos);

        for (var i = 0; i < adjacents.length; i++) {
            var v = adjacents[i];
            if (cells[v] == ".") {
                cells[v] = x;
                cells[pos] = ".";
                flush();
                return;
            }
        }
    }
}

// Start of solver:

function isUntouchable(x, y) {
}

function moveVoidToRow(y) {
}

function moveVoidToColumn(x) {
}

function moveVoidToPosition(x, y) {
	moveVoidToRow(y);
	moveVoidToColumn(x);
}

function moveVoidIntoQuadNotMovingTile(topX, topY, botX, botY, leaveX, leaveY) {
}

function moveTileToPosition(tile, toX, toY) {
	moveVoidToPosition(toX, toY);
	
	while (t.x != toX && t.y != toY) {
		rotateQuad(/* args */);
	}
}

post("15-puzzle", Date());
post();
this.autowatch = 1;
