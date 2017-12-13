/*

 Blowing Kitten Go!
 
 A lovely little kitten game warms up the morning and drawn when one is on the way to work/school and comes back home. 
 By blowing gentally the little kittey, a lovely black kitten jumps up over the ball quietly without distorbing people around you. 
 what is creative in this game is the way to play the game. it is out of the box that play a game need fingers on the phone.
 it is a great and nature way to communicate with machine and devices(any tools). it is also following the trend of AI.
 inspirations are from Pippin, when he showed a sound control game video in the class , and from a film called "Her" also.
 through an unexpected perspective, it is a novelty to the player and brings pleasure to them.
 
 this is a sound level controling game.  a player needs to learn to blow at the right moment and also need to learn how to blow 
 constantly and steably to get the best reasult. this game is constantly receiving input data from mic and analysis it to control
 how height the cat can jump in order to avoid collision. When the sound level is greater than 0.4, it is functional to control jumping process.
 when the current score is greater than a specific number(currently is 5), it speeds up the stones. The size of stones are randomly created 
 between 50 to 150 pixels. When cat starting jump and geting hit, sounds play. the movement of cat itself(rolling eyes) are controled by gifanimation library.
 cat in this game is a gif object, not a class. it is the way to simplify this game by removing unnecessary objects and codes.
 
 the end.
 */

import gifAnimation.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput mic;

// define an Gif object
Gif loopingGif;
int sizeCat = 50;
int xCat ;
int yCat ;
int vx = 0;
int vy = 0;
//Cat cat ;
boolean isJump = false;
int index = 1;  //jumping height parameter
int rate = 2; //

// An arraylist storing the stones

ArrayList<Stone> stones;
int stoneSize = 60;
int stoneValue = 1;

// game process control vaiables
boolean gameStart = true;
boolean gameOver = false;
float functionalPoint = 0.4; // sound level ,which is greater than 0.4 , can control the cat jump. 
int score = 0;
String bestScore ="";
float level = 0.0;

// collision flag
boolean overlap = false;

AudioPlayer jumpSound, hitSound;
FFT fft;

void setup() {

  size(824, 468);
  stones = new ArrayList<Stone>();

  xCat = width/5;
  yCat = height - sizeCat;
  minim = new Minim(this);
  // use minim.getLineIn() to get access to the microphone data 
  mic = minim.getLineIn();

  //setup framerate
  frameRate(20);

  //create the GifAnimation object
  imageMode(CORNER);
  loopingGif = new Gif(this, "images/rollingcat-maker.gif");
  loopingGif.play();

  // inisialize arraylist stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) {

    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue)); 
    xStone = xStone+ stones.get(i).size+stoneSize ;
  }

  //inisialize sound files while the hit and jump happens
  jumpSound = minim.loadFile("sounds/jump.wav");
  hitSound = minim.loadFile("sounds/hit.wav");
}

void draw() {
  // if it is the very beginning of the game, show opening screen of this game.
  if (gameStart) {

    setupGradientBG();
    drawOpeningScreen();
    level = mic.mix.level();
    if (level > functionalPoint) {
      gameStart = false;
    }
  } else {
    // if it is game running, show running cat screen of this game.
    setupGradientBG();
    // if game is not over, show spectrum, draw stone and cat, check if cat and stone got collided. 
    if (!gameOver) {
      // adding spectrum into this game
      for (int i =0; i< mic.bufferSize()-1; i++)
      {
        // the sound is MONO. so draw left or right specturm is the same. I draw the left here.
        line(i, 50+mic.left.get(i)*50, i+1, 50+mic.left.get(i+1)*50);
      }

      // variable index is for controlling the height of cat can jump.
      level = mic.mix.level();
      index = getIndex(level);

      if (!isJump && level > 0.1) {
        vy = -10;
        isJump = true;
        jumpSound.play();
      }
      if (isJump && yCat < height/index) { 
        vy = 10;
      }
      if (isJump && yCat > height - sizeCat) {
        isJump = false;
        yCat = height - sizeCat - 42;
        vy = 0;
        jumpSound.rewind();
      }
      yCat += vy;
      image(loopingGif, xCat, yCat);
      
      //
      for (int i = 0; i < stones.size(); i++) {
        stones.get(i).display();
        stones.get(i).update();
      }
      checkCollisions();
      showCurrentScore();
    } else { 
      // show game over screen and show current score and best score
      String [] fromText = loadStrings("record.txt");
      bestScore = fromText[0];
      if (score > parseInt(fromText[0])) {
        String[] test = new String[1];
        test[0] = Integer.toString(score);
        bestScore =  test[0];
        saveStrings("record.txt", test );
      } 
      showGameOverScreen();
      level = mic.mix.level();
      if (level > 0.4) {
        reset();
      }
    }
  }
}
// checkCollisions()
//
//check if cat and stone get overlaped. 
//the reason why I put this method in the main program is following the rules of "high cohesion and low interconnection"
// this state of collision belong to neighter stone or cat. 

void checkCollisions() {
  gameOver =false;
  for (int i = 0; i<stones.size(); i++) {

    if (dist(xCat, yCat, stones.get(i).x, stones.get(i).y)< stones.get(i).size + sizeCat/2) {
      gameOver=true;
      hitSound.play();
    }
  } 
  if (!gameOver) {
    int xStone = width + stoneSize;
    for (int i = 0; i < stones.size(); i++) {
      if (stones.get(i).x < 0) {  // when the stone touch the left border of screen?

        stones.remove(i);
        stoneSize = floor(random(50, 150));
        stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue));
        xStone = xStone+ stones.get(i).size+stoneSize + (int)random(100, 200);
      }
    }
  }
}

// mouseClicked()
//
// this method is for player who wishs to use mouse to restart the game.

void mouseClicked()
{
  if (gameStart)
  {
    gameStart = false;
  } else if (gameOver)
  {
    reset();
  }
}

void reset()
{
  // recreate a new ArrayList when player reset the game.
  stones = new ArrayList<Stone>();
  //stop play hit Sound
  hitSound.rewind();

  // set up flag to control the process of game (opening or closing)
  gameOver =false;
  gameStart =true;
  score = 0;
  // setup the position of cat
  xCat = width/5;
  yCat = height - sizeCat;

  // inisialize stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) { 
    // when reset() being called, create a new stone object with random size
    stoneSize = floor(random(50, 150));
    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue)); 
    xStone = xStone+ stones.get(i).size+stoneSize + (int)random(100, 200);
  }
}

void setupGradientBG()
{
  for (int i =0; i <height; i++)
  {
    color from = #0B2E63;
    color to =#00B6FF;
    float percentage = (float)i/height;
    color newColor = lerpColor(from, to, percentage);
    stroke(newColor);
    line(0, i, width, i);
  }
}

void drawOpeningScreen() {
  textSize(30);
  fill(255);
  //cat.showCat();
  image(loopingGif, xCat, yCat);
  text("Blowing Kitty Go!", width/2, height/2);
  text("Blow 'Puuu' to play!", width/2, height/2 + 50);

  for (int i =0; i< mic.bufferSize()-1; i++)
  {
    line(i, 50+mic.left.get(i)*50, i+1, 50+mic.left.get(i+1)*50);
  }
}

void showCurrentScore() {
  //checkScoreFlag = false;
  for (int i = 0; i < stones.size(); i++) {

    if (xCat > stones.get(i).x + stoneSize) {
      // println(stones.get(0).checkScoreFlag);
      if (stones.get(i).checkScoreFlag==false) 
      {

        stones.get(i).checkScoreFlag = true;
        score++;
      }
    }
  }
  fill(255);
  textSize(20);
  text("Score : "+score, width - 150, 40);
}

int getIndex(float level)
{
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
  // println("index = "+ index);
  return index;
}

void showGameOverScreen() {

  textSize(30);
  fill(255);
  text("Game Over", width/3, height/3);
  text("Score : ", width/3, height/3+ 50);
  text(score, width/3 + 125, height/3 + 50);
  text("Best Score : "+ bestScore, width/3, height/3 + 100 );         
  textSize(35);
  fill(#ffb119);
  text("Blow 'Puuuuu' to play", width/3, height/3 + 200);
  image(loopingGif, xCat, yCat+ sizeCat/2);
}