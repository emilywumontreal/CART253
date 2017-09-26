// This is a comment!

final int CIRCLE_SPEED = 7;
//changed shape color to grey
final color NO_CLICK_FILL_COLOR = color(100, 100, 100);
//changed shape color to white when click the mouse 
final color CLICK_FILL_COLOR = color(250, 250, 250);
//changed background color to random color.
final color BACKGROUND_COLOR = color(random(250), random(150), random(150));
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;

int circleX;
int circleY;
int circleVX;
int circleVY;
// changed by adding an variable to vary the circle size.
int currentCircleSize;

void setup() {
  // initialize a window which size is 640 pixels in width,460 pixels in height.
  size(640, 480);
  // set a value to variable circleX, circleY, circleVX and circleVY.
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  
  // changed initial curentCircleSize into 50 pixels
  currentCircleSize = 50;
  
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);  
  background(BACKGROUND_COLOR);
}


void draw() {
  // changed making circle size smaller 5 pixels while everytime draw the circle
  if (currentCircleSize == 5) currentCircleSize = 50;
  else currentCircleSize -= 1;
  
  if (dist(mouseX, mouseY, circleX, circleY) < currentCircleSize/2) {
    fill(CLICK_FILL_COLOR);
  }
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  //changed by switching fixable variable CIRCLE_SIZE to flexiable variable currentCircleSize
  ellipse(circleX, circleY, currentCircleSize, currentCircleSize); 
  circleX += circleVX;
  circleY += circleVY;
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR);
  }