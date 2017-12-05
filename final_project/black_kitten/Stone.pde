class Stone {


  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int value;
  int opening;
  color fill = color(255, 0, 0);
  boolean checkScoreFlag = false;

  // Stone(tempX, tempY, tempSize)
  //
  // Set up the Stone with the specified location, value and size
  // 
  Stone(int tempX, int tempY, int tempSize, int tempValue) {
    x = tempX;
    y = tempY;
    size = tempSize;
    value = tempValue;
  }

  // update()
  //
  // Move the Stones from right to left on the bottom of game window.
  void update()
  {
    int xMoveType = 7; //floor(random(1, 2));
    if(score > 5) xMoveType = 10;
    x -=xMoveType;
    //
    if (x < 0) {
      x += width;
      checkScoreFlag=false;
    }
  }

  // collide
  //

  //void collide(int xCat, int yCat) {

  //  // if cat hits on stones, game is over
  //  if (x >= xCat && y >= yCat) {
  //    // 
  //    overlap = true;

  //  }
  //}

  // display()
  //
  // Draw the stone on the screen as a rolling stone(round)
  void display() {
    //  fill(255); 
    noStroke();
    // fill(#ff9319); 
    // fill(#ffb119); 
    fill(#f3ffe4); //ECFEFF
    ellipse(x, y, size, size);
    fill(#ffb119); 
    ellipse(x, y, size/2, size/2);
    //    for (int i =0; i <size; i++)
    //    {
    //      color from = #ff9319;
    //      color to =#ff7600;
    //      float percentage = (float)i/size;
    //      //println(percentage);

    //      color newColor = lerpColor(from, to, percentage);
    //      stroke(newColor);
    //      //line(0, i, width, i);
    //      ellipse(x, y, i, i);
    //    }
  }
}