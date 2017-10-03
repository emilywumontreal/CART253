color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(100);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 120;
int paddleHeight = 16;
color paddleColor = color(135);

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);

// function setup()
//
// initializes the game window and call function setupPaddle and setupBall
void setup() {
  size(640, 480);
  setupPaddle();
  setupBall();
}
// setupPaddle function
//
// initailizes the pisition of paddle on the bottom middle of window
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}
// setupBall() function 
// 
// initailizes the position of ball in the midddle of window 
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}
// function draw() 
//
// main function to paint background and call every funtion that has been designed below
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}
// function drawStatic()
//
// draws background random gains within the window 
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float staticSize = random(staticSizeMin, staticSizeMax);
    fill(staticColor);
    rect(x, y, staticSize, staticSize);
  }
}
// function updatePaddle()
//
// set the position of paddle within the window
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX, 0+paddleWidth/2, width-paddleWidth/2);
}
// function updateBall()
//
// setup the next position of ball and also call the functions that handle the situdations of ball: hiting the wall, hitting the paddle and hiting the bottom 
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;

  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}
// function drawPaddle()
//
//draws paddle 
void drawPaddle() {
  rectMode(CORNER);
  noStroke();
  fill(paddleColor);
  // CHANGED draw colorful paddle with 10 random colors
  color colorPaddle;
  int tempX = paddleX - paddleWidth/2;
  for (int i = 0; i < 10; i++) {
    colorPaddle = color(random(250), random(150), random(150));
    fill(colorPaddle);
    rect(tempX, paddleY, paddleWidth/10, paddleHeight);
    tempX += paddleWidth / 10;
  }
  
  //rect(paddleX, paddleY, paddleWidth, paddleHeight);
}
// function drawBall()
//
// as the meaning of function name draws real-time ball
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}
// fuction handleBallHitPaddle()
//
//decides the direction of ball when ball hit the paddle relocated the ball by reduce the y-coodinate by 5
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
    // CHANGED the color of ball to random color when it hits the paddle
    ballColor = color(random(250), random(150), random(150));
  }
}
// function ballOverLapsPaddle()
//
// return a true/false value to where call this function to decide if the ball touches the paddle 
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}
// function handleBallOffBottom()
//
// setup the position of ball to the middle of window while the ball is off bottom.
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}
// ballOffBottom()
//
// Returning a boolean value if ball is off of bottom of the screen

boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}
// function handleBallHitWall()
//
// it is keeping ball bouncing off the walls
void handleBallHitWall() {
  // if the ball touches the left wall of the screen, set the ball to the right
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
    // if the ball touches the right wall of the screen, set the ball to the left
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  // if the ball touches the top of window, set the position of ball to the opposite direction 
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}
// while Left key is pressed and paddlke is not out of right wall, set the position of paddle to left
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}
// while Right key is pressed and paddle is not out of left wall, set the position of paddle to right
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}