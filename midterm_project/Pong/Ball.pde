// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int SIZE = 60;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  float vx;
  float vy;

  // The colour of the ball
  color ballColor = color(255);

  // CHANGED the look of the ball
  PImage imgBall;


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    //vx = SPEED;
    //vy = SPEED;
    vx = floor(random(-10, 10));
    vy = floor(random(-10, 10));
    //if (vy == 0) vy +=1;
    // if (vx == 0) vx +=1;
    if (dist(vx, 0, 0, vy) < SPEED) 
    {
      vx = SPEED;
      vy = SPEED;
    }
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    //x += vx;
    //y += vy;
    //x += random(width/2);
    //y += random(height/2);


    x += vx;
    y += vy;
    // println("x= "+x);
    // println("y= "+y);

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }

  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity

  void reset() {
    x = width/2;
    y = height/2;
  }

  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")

  boolean isOffScreen() {
    //CHANGED reset score when the ball is off the screen
    if (x + SIZE/2 < 0) {
      winner = "Player2";
      scorePlayer2 +=1;
      return true;
    }
    if (x - SIZE/2 > width) {
      winner = "Player1";
      scorePlayer1 +=1;
      return true;
    } 
    return false;
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
      //CHANGED counting variable plus 1
      //score +=1;
    }
  }


  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(ballColor);
    //rectMode(CENTER);
    //CHANGED imageMode to center
    imageMode(CENTER);
    // Draw the ball
    //rect(x, y, SIZE, SIZE); 

    //CHANGED the look of ball and transparency when the score goes higher
    imgBall = loadImage("images/redsphere.png");
    imgBall.resize(SIZE, SIZE);
    image(imgBall, x, y);
    // while the score is half of the full score, tint the color of the ball and reduce the size of the ball as well
    if (scorePlayer1 == isGameOver/2 || scorePlayer2 == isGameOver/2) {
      tint(255, 256/3);
      if (SIZE/3 >= 20) {
        SIZE = SIZE/2;
      }
    }
  }
}