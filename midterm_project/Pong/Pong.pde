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
int scorePlayer1 = 0;
int scorePlayer2 = 0;
//CHANGED adding a variable isGameOver to decide if the game is over

int isGameOver = 10;
//CHANGED adding a variable score to identyify the winner
String winner = "Player";

PImage imgBackground;
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

// CHANGED adding a function to show score in the background
void showScore() {
  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text(scorePlayer1, ball.x, ball.y + ball.SIZE);

  fill(0, 255, 255);
  text(scorePlayer2, ball.x + ball.SIZE, ball.y + ball.SIZE);
  //println("score is ", score);
}
// CHANGED adding a function that paint "Game over" window
void gameOver() {
  fill(0, 255, 0);
  textAlign(CENTER, CENTER);

  text("GAME OVER", width/2, height/2);
  fill(0, 255, 255);
  textSize(50);
  text(winner+" WON!", width/2, height/2-80);
}

// CHANGED the look of PONG game, change the background and the skin of ball
//void setGameLooks() {
//}