outlets = 2;
inlets = 2;

function bang() {
	post(Math.random());
	post();
}

function msg_int(i, j) {
	post("Inlet is", inlet);
	post("INT", i, j);
	post();
	outlet(0, i + j);
}

function orange() {
	var r = Math.random();
	var g = Math.random();
	var b = Math.random();
	outlet(1, "clear");
	outlet(1, "setall", 1, r, g, b);
	outlet(1, "bang");
}
