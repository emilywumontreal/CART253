/* This is a comment!
   This code is about drawing a moving eclipse along a refection within borders of a window
   It is kind of like boncing shape within the frame of window. 
*/
// set step
final int CIRCLE_SPEED = 7;
//changed shape color to grey
final color NO_CLICK_FILL_COLOR = color(100, 100, 100);
//changed shape color to white when click the mouse 
final color CLICK_FILL_COLOR = color(250, 250, 250);
//changed background color to random color.
final color BACKGROUND_COLOR = color(random(250), random(150), random(150));
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;
// declare variable
int circleX;
int circleY;
int circleVX;
int circleVY;
// changed by adding an variable to vary the circle size.
int currentCircleSize;

void setup() {
  // initialize a window which size is 640 pixels in width,460 pixels in height.
  size(640, 480);
  // set values to variable circleX, circleY, circleVX and circleVY.
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  
  // changed initial curentCircleSize into 50 pixels
  currentCircleSize = 50;
  
  // set pink-like stroke color
  stroke(STROKE_COLOR);
  // set ellipse color grey
  fill(NO_CLICK_FILL_COLOR); 
  // set backgroud color
  background(BACKGROUND_COLOR);
}


void draw() {
  // changed making circle size smaller 5 pixels while everytime draw the circle, if circle size is 5, set it's value 50 going over again
  if (currentCircleSize == 5) currentCircleSize = 50;
  else currentCircleSize -= 5;
  
  // if the distance between the position of mouse and  the left top position of eclipse is less than half of currentCircleSize, paint grey color ,otherwise paint black
  if (dist(mouseX, mouseY, circleX, circleY) < currentCircleSize/2) {
    fill(CLICK_FILL_COLOR);
  }
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  // changed by switching fixable variable CIRCLE_SIZE to flexiable variable currentCircleSize for varying the size of the eclipses
  ellipse(circleX, circleY, currentCircleSize, currentCircleSize); 
  // increase circleX and circleY by 7 each step, which is the value of CIRCLE_SPEED
  circleX += circleVX;
  circleY += circleVY;
  // if circleX plus 25 greater than the width of window or circleX reduces 25 less than zero, then reduce 7 from cricleVX (when the x-coordinate of eclipse is out of window frame, make eclipse gos back)
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  // if circleY plus 25 greater than the hight of window or circleX reduces 25 less than zero, then reduce 7 from cricleVY (when the y-coordinate of eclipse is out of window frame, make eclipse gos back)
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

/* mousePressed function 
   when mouse pressed, repaint the background by random color. it erases all the shapes in the window
*/
void mousePressed() {
  background(BACKGROUND_COLOR);
  }