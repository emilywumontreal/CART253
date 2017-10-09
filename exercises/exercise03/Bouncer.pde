// definition of class Bouncer
// build a constructor of class Bouncer
// name the variables, parameters and methods in class Bouncer 

class Bouncer {
  // properties of class Bouncer 
  int x;
  int y;
  int vx;
  int vy;
  int size;
  color fillColor;
  color defaultColor;
  color hoverColor;
  // constructor of class including 6 parameters, which are receiving from the caller by using reserved word 'new'.
  Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    hoverColor = tempHoverColor;
    fillColor = defaultColor;
  }
  // method update()
  //
  // update the position of the bouncer move and respose the action of mouse.
  void update() {
    x += vx;
    y += vy;

    handleBounce();
    handleMouse();
  }
  // method handleBounce
  //
  // judge the location of bouncer: if it is out of window, set it back and remain the bouncer inside of window
  void handleBounce() {
    if (x - size/2 < 0 || x + size/2 > width) {
      vx = -vx; 
      //CHANGED if bouncer touch the left or right of wall, size of eclipse plus 1
      size += 1;
    }
    //CHANGED if bouncer touch the bottom or top of wall, size of eclipse plus 1
    if (y - size/2 < 0 || y + size/2 > height) {
      vy = -vy;
      size += 1;
      println("from handleBounce(), which increasing current size = ",size);
    }

    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }
  // method handleMouse()
  //
  // change color if mouse inside of the bouncer
  void handleMouse() {
    if (dist(mouseX, mouseY, x, y) < size/2) {
      fillColor = hoverColor;
    } else {
      fillColor = defaultColor;
    }
  }
  // method draw()
  //
  // draw a bouncer without stroke, with a specific color and size
  void draw() {
    noStroke();
    fill(fillColor);
    ellipse(x, y, size, size);
  }
  // method decreaseSize()
  //
  // CHANGED new method when mouse clicked inside the eclipse, decrease size step by 5, if size less than 5 than set size = 1
  void decreaseSize() {
    if (dist(mouseX, mouseY, x, y) < size/2) {
    if (size >= 5) {
      size -= 5;
    } else {
      size = 1;
    }
    }
    println("current size from decreaseSize() = ",size);
   
  }
}