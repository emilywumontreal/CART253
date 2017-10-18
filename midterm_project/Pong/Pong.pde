// Pong //<>//
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// scoring:
// the finishing score will be 10. In this case finishing score is setted by giving value to the variable isGameOver.
// if the ball is off of screen on the left side then the player on the right side win one point. vice versa
// whoever fristly get the 10 points, this player will be the winner. 
// 
// score display:
// two players have their own scores showing under the ball
// 
// the looks of game:
// changed the looks of the background and the ball and the paddle. 
// when the score is half way of the full score, the ball will be transparant and the size will be reduce to 1/2 original size
// 

// the way of controling two paddles:
// save the original way of controlling the paddle and also added a new way to control by clicking the mouse. when 
// the mouse pressed on the right side of the window, the right paddle is working. vice versa. 

// the way of setting the move of the ball
// setting a random vx&vy from -10 to 10 while the ball has been created by the construction method of class Ball.
// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// The background colour during play (black)
color backgroundColor = color(0);

//CHANGED adding variable score to identify how many times the ball has been bouncing before the game is over( while the ball get off the left or right of window )
int scorePlayer1 = 0;
int scorePlayer2 = 0;
//CHANGED adding a variable isGameOver to decide if the game is over

int isGameOver = 10;
//CHANGED adding a variable score to identyify the winner
String winner = "Player";
// CHANGED add background of the game
PImage imgBackground;

// CHANGED add a variable controlFlagOfPaddle to decide which paddle is avaliable when the mouse pressed
char controlFlagOfPaddle = 'L';
// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);
  // CHANGED background picture
  imgBackground = loadImage("images/background.jpg");
  imgBackground.resize(640, 480);
  background(imgBackground);
  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '0', 'p');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  background(imgBackground);

  //CHANGED adding a condition that game is over or not
  if (scorePlayer1 < isGameOver && scorePlayer2 < isGameOver) {
    //  println("scoreplayer1=",scorePlayer1);
    //  println("scoreplayer2=",scorePlayer2);
    // Update the paddles and ball by calling their update methods
    leftPaddle.update();
    rightPaddle.update();
    ball.update();

    // Check if the ball has collided with either paddle
    ball.collide(leftPaddle);
    ball.collide(rightPaddle);

    // Check if the ball has gone off the screen
    if (ball.isOffScreen()) {
      // If it has, reset the ball
      ball.reset();

      //isGameOver +=1;
    }

    // Display the paddles and the ball
    leftPaddle.display();
    rightPaddle.display();
    ball.display();
    showScore();
  } else {
    gameOver();
  }
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}

// CHANGED add a function to check if mouse is pressed and the mouseX is left half of the window. then redraw the left paddle, otherwise redraw the rightpaddle
void mousePressed() {
  if (mouseX >= width/2) {
    controlFlagOfPaddle = 'R';
  } else 
  {
    controlFlagOfPaddle = 'L';
  }
  if (controlFlagOfPaddle == 'L') 
    leftPaddle.mousePressed();
  else 
  rightPaddle.mousePressed();
}
// CHANGED 
// showScore()
//
// adding a function to show score beside of the ball
void showScore() {
  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  if (ball.SIZE/3 <=20)  textSize(20);
  else textSize(ball.SIZE/3);
  
  text(scorePlayer1, ball.x-ball.SIZE/4, ball.y + ball.SIZE/2);

  fill(0, 255, 255);
  textAlign(CENTER, CENTER);
  text(scorePlayer2, ball.x+ball.SIZE/4, ball.y + ball.SIZE/2);
}

// CHANGED 
// function gameOver
//
// adding a function that paint "Game over" window
void gameOver() {
  fill(0, 255, 0);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
  fill(0, 255, 0);
  textSize(25);
  text(winner+" WON!", width/2, height/2-80);
}

// CHANGED the look of PONG game, change the background and the skin of ball
//void setGameLooks() {
//}