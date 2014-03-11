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

function random() {
	var r = Math.random();
	var g = Math.random();
	var b = Math.random();
	outlet(1, "clear");
	outlet(1, "setall", 1, r, g, b);
	outlet(1, "bang");
}

function random2x2() {
	var r1 = Math.random();
	var g1 = Math.random();
	var b1 = Math.random();
	
	var r2 = Math.random();
	var g2 = Math.random();
	var b2 = Math.random();

	outlet(1, "setcell", 0, 0, "val", 1, r1, g1, b1);
	outlet(1, "setcell", 1, 1, "val", 1, r1, g1, b1);

	outlet(1, "setcell", 0, 1, "val", 1, r2, g2, b2);
	outlet(1, "setcell", 1, 0, "val", 1, r2, g2, b2);

	outlet(1, "bang");
}

function highlight(frame, x, y) {
	// Returns an index into a selection of colours.
	//return (x + y) % 2 == 0;
	
	//return (y > x) || (x < 32);
	
	//return (y > x);
	//return (y > x) != (x + y < 64);
	
	//if (x == y) return 0;
	
	//if (x + y == 63) return 1;
	
	if (frame - 20 > (x ^ y)) { return 0; }
	if (frame - 10 > (x ^ y)) { return 1; }
	if (frame < (x ^ y)) { return 3; } else { return 2; }
}

// http://stackoverflow.com/questions/17242144/javascript-convert-hsb-hsv-color-to-rgb-accurately

HSBToRGB = function (hsb) {
                    var rgb = {};
                    var h = Math.round(hsb.h);
                    var s = Math.round(hsb.s * 255 / 100);
                    var v = Math.round(hsb.b * 255 / 100);
                    if (s == 0) {
                        rgb.r = rgb.g = rgb.b = v;
                    } else {
                        var t1 = v;
                        var t2 = (255 - s) * v / 255;
                        var t3 = (t1 - t2) * (h % 60) / 60;
                        if (h == 360) h = 0;
                        if (h < 60) { rgb.r = t1; rgb.b = t2; rgb.g = t2 + t3 }
                        else if (h < 120) { rgb.g = t1; rgb.b = t2; rgb.r = t1 - t3 }
                        else if (h < 180) { rgb.g = t1; rgb.r = t2; rgb.b = t2 + t3 }
                        else if (h < 240) { rgb.b = t1; rgb.r = t2; rgb.g = t1 - t3 }
                        else if (h < 300) { rgb.b = t1; rgb.g = t2; rgb.r = t2 + t3 }
                        else if (h < 360) { rgb.r = t1; rgb.g = t2; rgb.b = t1 - t3 }
                        else { rgb.r = 0; rgb.g = 0; rgb.b = 0 }
                    }
                    return { r: Math.round(rgb.r), g: Math.round(rgb.g), b: Math.round(rgb.b) };
}

function testHSB(h, s, b) {
	result = HSBToRGB( {h: h, s: s, b: b} )
	post("HSB to RGB", result.r, result.g, result.b, "\n");
}

var allColours;

for (var i = 0; i < 7; i++) {
}


var colour1 = [Math.random(), Math.random(), Math.random()];
var colour2 = [Math.random(), Math.random(), Math.random()];

function pattern(frame) {
	var white = [1, 1, 1];
	var black = [0, 0, 0];
	
	var allColours = [colour1, colour2, white, black];
	
	var colour;
	
	for (var y = 0; y < 64; y++) {
		for (var x = 0; x < 64; x++) {
			colour = allColours[highlight(frame, x, y)];
			
			outlet(1, "setcell", x, y, "val", 1,
 				   colour[0], colour[1], colour[2]
				  );
		}
	}

	outlet(1, "bang");
}
