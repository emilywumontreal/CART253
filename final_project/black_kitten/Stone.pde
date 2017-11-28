class Stone {


  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int opening;
  color fill = color(255, 0, 0);

  // Stone(tempX, tempY, tempSize)
  //
  // Set up the Stone with the specified location and size
  // 
  Stone(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  // update()
  //
  // Move the Stones from right to left on the bottom of game window.
  void update()
  {
    int xMoveType = 8; //floor(random(1, 2));
    x -=xMoveType;
    //
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }
    //
  }
  void updateOld() {

    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // 
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }
  }

  // collide
  //

  void collide(Cat iCat) {

    // if cat hits on stones, game is over
    if (x >= iCat.x && y >= iCat.y) {
      // 
      overlap = true;
      // Constrain the energy level to be within bounds
      //energy = constrain(energy,0,maxEnergy);
    }
  }

  // display()
  //
  // Draw the stone on the screen as a rolling stone(round)
  void display() {
    fill(255); 
    noStroke();
    ellipse(x, y, size, size);
  }
}