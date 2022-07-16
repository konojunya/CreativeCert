const rectSize = 20;

function setup() {
  createCanvas(windowWidth, windowHeight);
  noLoop();
  noStroke();
}

function draw() {
  // draw background
  background(255);
  fill(50);

  for (let i = 0; i < windowWidth; i += rectSize * 2) {
    for (let j = 0; j < windowHeight; j += rectSize * 2) {
      drawRect(i, j);
      drawBorder1(i + rectSize, j);
      drawBorder2(i, j + rectSize);
    }
  }

  // draw key area
  fill("#212121");
  const keyAreaHeight = 300;
  rect(
    width / 2 - windowWidth / 2,
    height / 2 - keyAreaHeight / 2,
    windowWidth,
    keyAreaHeight
  );

  fill(255);
  const barHeight = 30;
  rect(0, height / 2 - 100, windowWidth, barHeight);
  rect(0, height / 2 + 70, windowWidth, barHeight);

  textAlign(CENTER, CENTER);
  textSize(100);
  textStyle(BOLD);
  text(`123456`, width / 2, height / 2);
}

// rect
function drawRect(x, y) {
  push();
  translate(x, y);
  rect(0, 0, rectSize, rectSize);
  pop();
}

function drawBorder1(x, y) {
  push();
  translate(x, y);
  triangle(0, 0, rectSize / 3, 0, 0, rectSize / 3);
  quad(
    rectSize,
    0,
    rectSize,
    rectSize / 2,
    rectSize / 2,
    rectSize,
    0,
    rectSize
  );
  pop();
}

function drawBorder2(x, y) {
  push();
  translate(x, y);
  quad(rectSize / 2, 0, rectSize, 0, 0, rectSize, 0, rectSize / 2);
  triangle(
    rectSize,
    (rectSize / 3) * 2,
    rectSize,
    rectSize,
    (rectSize / 3) * 2,
    rectSize
  );
  pop();
}
