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

post("15-puzzle", Date());
post();
