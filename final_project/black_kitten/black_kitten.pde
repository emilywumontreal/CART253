//import processing.sound.*;

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
boolean jumping = false;
int index = 1;  //jumping height parameter
int rate = 2; //

// An arraylist storing the stones

ArrayList<Stone> stones;
int stoneSize = 60;
int stoneValue = 1;

boolean gameStart = true;
boolean gameOver = false;
int score = 0;
String bestScore ="";



boolean overlap = false;
boolean paused =false;

AudioPlayer jumpSound, hitSound;
FFT fft;

void setup() {
  size(824, 468);
  stones = new ArrayList<Stone>();

  xCat = width/5;
  yCat = height - sizeCat;

  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data 
  mic = minim.getLineIn();

  //Changed framerate
  frameRate(20);
  //create the GifAnimation object
  imageMode(CORNER);
  loopingGif = new Gif(this, "images/rollingcat-maker.gif");
  loopingGif.play();

  // inisialize arraylist stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) {
    stoneSize = floor(random(50, 150));
    if (stoneSize >= 90 && stoneSize < 130) stoneValue = 2;
    if (stoneSize >= 130 && stoneSize < 160) stoneValue = 3;
    if (stoneSize >= 160 && stoneSize < 200) stoneValue = 4;
    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue)); 
    // println("stonesize"+stoneSize);
    xStone = xStone+ stones.get(i).size+stoneSize ;//+ (int)random(100, 200);
  }

  //inisialize sound files while the hit and jump happens
  jumpSound = minim.loadFile("sounds/jump.wav");
  hitSound = minim.loadFile("sounds/hit.wav");
}

void draw() {

  if (gameStart) {

    setupGradientBG();
    //background(#497ED6);//(#0B2E63);
    drawOpeningScreen();
    float level = mic.mix.level();
    // draw sound lines
    if (level > 0.4) {
      println("level= "+level);
      gameStart = false;
    }
  } else {

    setupGradientBG();
    if (!gameOver) {
      // adding spectrum into this game
      for (int i =0; i< mic.bufferSize()-1; i++)
      {
        line(i, 50+mic.left.get(i)*50, i+1, 50+mic.left.get(i+1)*50);
        //line(i, 150+mic.right.get(i)*50, i+1, 150+mic.right.get(i+1)*50);
      }
      float level = mic.mix.level();
      //draw a level bar here by input voice?
      // Adding variable level to adjust the height of cat jumping
      index = getIndex(level);
      if (!jumping && level > 0.1) {
        vy = -10;
        jumping = true;
        jumpSound.play();
      }
      if (jumping && yCat < height/index) { 
        vy = 10;
      }
      if (jumping && yCat > height - sizeCat) {
        jumping = false;
        yCat = height - sizeCat - 42;
        vy = 0;
        jumpSound.rewind();
      }
      yCat += vy;
      image(loopingGif, xCat, yCat);

      for (int i = 0; i < stones.size(); i++) {
        stones.get(i).display();
        stones.get(i).update();
      }
      checkCollisions();
      showCurrentScore();
    } else {
      String [] fromText = loadStrings("record.txt");
       bestScore = fromText[0];
      if (score > parseInt(fromText[0])) {
        String[] test = new String[1];
        test[0] = Integer.toString(score);
        bestScore =  test[0];
        saveStrings("record.txt", test );
      } 
      showGameOverScreen();
      float level = mic.mix.level();
      if (level > 0.4) {
        reset();
      }
    }
  }
}

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
      if (stones.get(i).x < 10) {  // when the stone touch the left border of screen?
        stones.remove(i);
        stoneSize = floor(random(50, 150));
        println("stonesize"+ stoneSize);
        stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue));
        xStone = xStone+ stones.get(i).size+stoneSize + (int)random(100, 200);
      }
    }
  }
}
void mouseClicked()
{

  //if (mouseButton == LEFT)
  //{
  if (gameStart)
  {
    gameStart = false;
  } else if (gameOver)
  {
    // println("gameOver = "+gameOver);
    reset();
  }
  //} //else  if (mouseButton == RIGHT)
  // {
  //  paused=!paused;
  // }
}

void reset()
{
  //stop hitSound
  stones = new ArrayList<Stone>();
  //  println("in reset");
  hitSound.rewind();

  paused=false;
  // set up flag to control the process of game (opening or closing)
  gameOver =false;
  gameStart =true;
  score = 0;
  //
  xCat = width/5;
  yCat = height - sizeCat;
  // inisialize stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) { //stones.size()

    stoneSize = floor(random(50, 150));
    println(stoneSize);
    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize, stoneValue)); 
    //stones[i] = new Stone(xStone, height-stoneSize/2, stoneSize); 
    //stoneSize = floor(random(50, 200));
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
    //println(percentage);

    color newColor = lerpColor(from, to, percentage);
    stroke(newColor);
    line(0, i, width, i);
  }
}

void drawOpeningScreen() {
  textSize(30);
  fill(255);
  image(loopingGif, xCat, yCat);
  text("Blowing Kitty Go!", width/2, height/2);
  text("Blow 'Puuu' to play!", width/2, height/2 + 50);
  //

  /* adding spectrum into this game
   fft = new FFT( 8, 512);
   for (int i = 0; i < fft.specSize(); i++)
   { 
   println("sound map drawing");
   // draw the line for frequency band i, scaling it up a bit so we can see it
   line( i+20, height, i+20, height - fft.getBand(i)*8 );
   }*/
  for (int i =0; i< mic.bufferSize()-1; i++)
  {
    line(i, 50+mic.left.get(i)*50, i+1, 50+mic.left.get(i+1)*50);
    //line(i, 150+mic.right.get(i)*50, i+1, 150+mic.right.get(i+1)*50);
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
  println("index = "+ index);
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