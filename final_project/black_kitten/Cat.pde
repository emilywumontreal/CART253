class Cat {
  float x, y, ySpeed;
  Cat() {
    x = width/3;
    y = height - size;
  }
  void showCat() {
    ellipse(x, y, 20, 20);
  }
  void jump() {
    ySpeed=-10;
  }
  void drag() {
    ySpeed+=0.4;
  }
  void move() {
    y+=ySpeed; 
    for (int i = 0; i<3; i++) {
     // stones[i].x -= 3;
    }
  }
  //void checkCollisions() {
  //  if (gameOver) {
  //    gameOver=false;
  //  }
  //  for (int i = 0; i<3; i++) {
  //    if ((x<stones[i].x + 10 && x > stones[i].x-10) && (y < stones[i].opening-100||y > stones[i].opening + 100)) {
  //      gameOver=false;
  //    }
  //  }
  //}
}