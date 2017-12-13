/*
This is an class of barrier, called stone, which is used to prevent little cat moves and increase
 the difficulty level of the game by speeding up the stone.
 */
class Stone {

  int x;
  int y;
  int size;
  int value;
  int xSpeed = 7;
  int scoreLevel2 = 5;
  int speedLevel2 = 10;
  color fill = color(255, 0, 0);
  boolean checkScoreFlag = false;

  // Stone(tempX, tempY, tempSize)
  //
  // Set up the Stone with the specified location, value and size
  // for this version, variable value is not been used. it is a 
  // going-to-do function.
  Stone(int tempX, int tempY, int tempSize, int tempValue) {
    x = tempX;
    y = tempY;
    size = tempSize;
    value = tempValue;
  }

  // update()
  //
  // Move the Stones from right to left on the bottom of game screen.
  void update()
  {
    //  if current score is greater than levelTwo score which is 5 currently, the stone gets speed up to next level.
    if (score > scoreLevel2) xSpeed = speedLevel2;
    x -=xSpeed;

  }


  // display()
  //
  // Draw a rolling stone on the screen.
  void display() {

    noStroke();
    fill(#f3ffe4); 
    ellipse(x, y, size, size);
    fill(#ffb119); 
    ellipse(x, y, size/2, size/2);

  }
}