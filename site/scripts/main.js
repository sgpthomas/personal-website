function BoatDimensions(boatW, boatH, mastH, sailH) {
    return {
	boatW, boatH, mastH, sailH,
	totalHeight: function() {
	    return this.boatH + this.mastH + this.sailH
	},
	totalWidth: function() {
	    return this.boatW
	}
    }
}

// x, y refer to the coords of the bottom center of the boat
function boat(ctx, x, y, dims, rotation) {
    ctx.translate(x, y);
    ctx.rotate(rotation);
    ctx.translate(-x, -y);

    let bx = x - (dims.boatW / 2);
    let by = y - dims.boatH;

    // draw body of boat
    ctx.strokeRect(bx, by, dims.boatW, dims.boatH);

    ctx.beginPath();
    // draw mast
    ctx.moveTo(x, by);
    ctx.lineTo(x, by - dims.mastH);

    ctx.lineTo(x - (dims.boatW * (1/3)), by - dims.mastH); // to front of boat
    ctx.lineTo(x, by - dims.mastH - dims.sailH); // top of sail
    ctx.lineTo(x + (dims.boatW * (1/3)), by - dims.mastH); // back of boat

    ctx.lineTo(x, by - dims.mastH); // back home

    ctx.stroke();
    ctx.resetTransform();
}

function wavey(ctx, waveWidth, width, height) {
    ctx.lineWidth = 1;

    ctx.beginPath();

    // add a buffer to the height so that we don't get pixel cutoff
    // height = height - buffer;
    let buffer = 10;

    let numWaves = Math.floor(width / waveWidth) + 1;

    for (let i = 0; i < numWaves; i++) {

	let startPoint = {
	    x: i * waveWidth,
	    y: height / 2
	};
	let endPoint = {
	    x: (i + 1) * waveWidth,
	    y: height / 2
	};

	let controlPoint;
	if (i % 2 == 1) {
	    controlPoint = {
		x: i * waveWidth + (waveWidth / 2),
		y: height * (3/2) - buffer
	    };
	} else {
	    controlPoint = {
		x: i * waveWidth + (waveWidth / 2),
		y: buffer - (height / 2)
	    };
	}

	ctx.moveTo(startPoint.x, startPoint.y);
	ctx.quadraticCurveTo(controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);

    }

    ctx.stroke();

    // draw boat
    let boatWave = 4;
    let boatDims = new BoatDimensions(18, 8, 5, 12);
    boat(
	ctx,
	(boatWave * waveWidth), // x
	(height / 2),  // y
	boatDims,
	-45 * Math.PI / 180
    );
}

function spiky(ctx, spikeWidth, width, height) {
    // set fill and stroke styles
    ctx.lineWidth = 1;

    ctx.beginPath();

    let numSpikes = Math.floor(width / spikeWidth) + 2;

    let boatWave = 7;
    let boatPos = {};
    let buffer = 15;

    for (let i = 0; i < numSpikes; i++) {
	let xCoord = i*spikeWidth;
	let yCoord;
	let variance = Math.random() * ((height - (2 * buffer)) / 2.4);
	if (i % 2 == 1) {
	    yCoord = height - variance - buffer;
	} else {
	    yCoord = buffer + variance;
	}

	ctx.lineTo(xCoord, yCoord);

	if (i == boatWave) {
	    boatPos.x1 = xCoord;
	    boatPos.y1 = yCoord;
	} else if (i-1 == boatWave) {
	    boatPos.x2 = xCoord;
	    boatPos.y2 = yCoord;
	}
    }

    ctx.stroke();

    console.log(boatPos);

    // draw boat
    let boatDims = new BoatDimensions(18, 8, 5, 12);
    let radians = Math.atan(
	Math.abs(boatPos.x2 - boatPos.x1) / Math.abs(boatPos.y1 - boatPos.y2)
    );
    let x = boatWave * spikeWidth;
    let y = (height / 2) - (boatDims.totalHeight() / 4);
    boat(
	ctx,
	(boatPos.x2 + boatPos.x1) / 2, // x
	(boatPos.y1 + boatPos.y2) / 2,  // y
	boatDims,
	radians - (Math.PI / 2)
    );
}

// ~~~ waves ~~~~
let wave = document.querySelector('#wave');
let waveCanvas = wave.querySelector('canvas');

waveCanvas.width = wave.clientWidth;
waveCanvas.height = wave.clientHeight;

let waveCtx = waveCanvas.getContext('2d');


// Spikes!!1
let spikeContainer = document.querySelector('#spike');
let spikeCanvas = spikeContainer.querySelector('canvas');

spikeCanvas.width = spikeContainer.clientWidth;
spikeCanvas.height = spikeContainer.clientHeight;

let spikeCtx = spikeCanvas.getContext('2d');

if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
    waveCtx.strokeStyle = 'white';
    spikeCtx.strokeStyle = 'white';
} else {
    waveCtx.strokeStyle = 'black';
    spikeCtx.strokeStyle = 'black';
}

wavey(waveCtx, 40, waveCanvas.width, waveCanvas.height);

spiky(spikeCtx, 20, spikeCanvas.width, spikeCanvas.height);


