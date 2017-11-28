//import processing.sound.*;

import gifAnimation.*;
import ddf.minim.*;

Minim minim;
AudioInput mic;

// define an Gif object
Gif loopingGif;
// define the default location of gif object
//int x = 0;
//int y = height - size/2;

int sizeCat = 50;
int xCat ;
int yCat ;
int vx = 1;
int vy = 0;
boolean jumping = false;
int index = 1;
int rate = 2;


// Adding stone on the screen
// An array storing all the stones
Stone[] stones = new Stone[3];
int stoneSize = 60;

boolean gameStart = true;
boolean gameOver = false;
int score = 0;

boolean overlap = false;


void setup() {
  size(824, 468);
  xCat = width/5;
  yCat = height - sizeCat;

  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data 
  mic = minim.getLineIn();

  //Changed framerate
  frameRate(30);
  //create the GifAnimation object
  imageMode(CORNER);
  loopingGif = new Gif(this, "rollingcat-maker.gif");

  loopingGif.loop();

  // inisialize all 100 stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < stones.length; i++) {

    stones[i] = new Stone(xStone, height-stoneSize/2, stoneSize); 
    stoneSize = floor(random(50, 200));
    xStone = xStone+ stones[i].size+stoneSize + (int)random(100, 200);
  }
}

void draw() {
  background(255, 227, 148);
  if (gameStart) {
  //  println("aaaaaaaaaa");
    image(loopingGif, xCat, yCat);
    text("Yelling Kitten Go!", width/2, height/2);
    text("Yelling 'GO' to play!", width/2, height/2);
    gameStart = false;  
    
    // adding code to receive the command from player
    
    //pause();
  } else {
    if (!gameOver) {
    float level = mic.mix.level();

    //println(level);
    // Adding variable level to adjust the height of cat jumping
    if (level <= 0.1) index = 1;
    if (level > 0.1 && level <=0.2) index = 1*rate;
    if (level > 0.2 && level <=0.3) index = 2*rate;
    if (level > 0.3 && level <=0.4) index = 3*rate;
    if (level > 0.4 && level <=0.5) index = 4*rate;
    if (level > 0.5 && level <=0.6) index = 5*rate;
    if (level > 0.6 && level <=0.7) index = 6*rate;
    if (level > 0.7 && level <=0.8) index = 7*rate;
    if (level > 0.8 && level <=0.9) index = 8*rate;
    if (level > 0.9 && level <=1.0) index = 9*rate;
    if (level > 1.0) index = 10*rate;
    // println("index=", index);
    if (!jumping&& level > 0.1) {
      vy = -10;
      jumping = true;
    }

    if (jumping && yCat < height/index) { 
      vy = 10;
    }
    if (jumping && yCat > height - sizeCat) {
      jumping = false;
      yCat = height - sizeCat;
      vy = 0;
    }
    yCat += vy;
    image(loopingGif, xCat, yCat);

    for (int i = 0; i < stones.length; i++) {
      stones[i].display();
      stones[i].update();
    }
    checkCollisions();
  } else {
   
    textSize(65);
    text("Game Over", 170, 140);
    text("Score", 180, 240);
    text(score, 450, 240);
    fill(255);
    textSize(25);
    text("Saying 'Playyyyyyy' 3 seconds for replay", 180 ,340);
  }
}
}

void checkCollisions() {
  gameOver =false;
  println(abs(xCat - stones[0].x));
  for (int i = 0; i<stones.length; i++) {
    if (abs(xCat - stones[i].x) < (stones[i].size + sizeCat/2) ) {

      gameOver=true;
      println("collison! gameover");
    }
  }
}