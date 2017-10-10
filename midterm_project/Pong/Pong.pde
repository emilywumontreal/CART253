// Pong //<>//
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// The background colour during play (black)
color backgroundColor = color(0);

//CHANGED adding variable score to identify how many times the ball has been bouncing before the game is over( while the ball get off the left or right of window )
int score = 0;
//CHANGED adding a variable isGameOver to decide if the game is over
int isGameOver = 0;
int gameOver = 5;
//CHANGED adding a variable score to identyify the winner
char winner = 'U';



// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);

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
  background(backgroundColor);
  //CHANGED adding a condition that game is over or not
  if (isGameOver <= gameOver) {
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
      //CHANGED reset score as 0 when the ball is off the screen and isGameOver plus 1 (if isGameOver is greater than 5, game is over)
      score = 0;
      isGameOver +=1;
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

// CHANGED adding a function to show score in the background
void showScore() {
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text(score, ball.x + ball.SIZE, ball.y + ball.SIZE);
  //println("score is ", score);
}
// CHANGED adding a function that paint "Game over" window
void gameOver() {
  fill(0, 255, 0);
  textAlign(CENTER, CENTER);
  
  text("GAME OVER", width/2, height/2);
  fill(0, 255, 255);
  textSize(50);
  text(winner+" PLAYER WON",width/2, height/2-80);
}