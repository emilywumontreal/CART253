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
int index = 1;
int rate = 2;

// An arraylist storing all the stones
//Stone[] stones = new Stone[2];
ArrayList<Stone> stones;
int stoneSize = 60;

boolean gameStart = true;
boolean gameOver = false;
int score = 0;
String[] bestScore;

boolean overlap = false;
boolean paused =false;

AudioPlayer jumpSound, hitSound;
FFT fft;

void setup() {
  size(824, 468);
  //  bestScore[0] = new String("");
  bestScore = new String[]{"0"};
  stones = new ArrayList<Stone>();

  xCat = width/5;
  yCat = height - sizeCat;

  minim = new Minim(this);

  // We use minim.getLineIn() to get access to the microphone data 
  mic = minim.getLineIn();

  //Changed framerate
  frameRate(30);
  //create the GifAnimation object
  imageMode(CORNER);
  loopingGif = new Gif(this, "/images/rollingcat-maker.gif");

  loopingGif.play();

  // inisialize arraylist stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) {

    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize)); 
    stoneSize = floor(random(50, 200));
    xStone = xStone+ stones.get(i).size+stoneSize ;//+ (int)random(100, 200);
  }
  //inisialize sound files while the hit and jump happens
  jumpSound = minim.loadFile("sounds/jump.wav");
  hitSound = minim.loadFile("sounds/hit.wav");
}

void draw() {

  if (gameStart) {
    background(#497ED6);//(#0B2E63);
    textSize(30);
    image(loopingGif, xCat, yCat);
    text("Blowing Kitty Go!", width/2, height/2);
    text("Blow 'Puuu' to play!", width/2, height/2 + 50);
    // adding spectrum into this game
    fft = new FFT( 8, 512);
    for (int i = 0; i < fft.specSize(); i++)
    { 
      println("band map");
      // draw the line for frequency band i, scaling it up a bit so we can see it
      line( i, height, i, height - fft.getBand(i)*8 );
    }
  } else {
    if (paused==false)
    {
      background(#497ED6);//background(#0B2E63);
      if (!gameOver) {
        //
        // adding spectrum into this game
        fft = new FFT( 8, 512);
        for (int i = 0; i < fft.specSize(); i++)
        {      
          // draw the line for frequency band i, scaling it up a bit so we can see it
          line( i, height, i, height - fft.getBand(i)*8 );
          //  line(30,130,80,250);
          // println("band map");
        }

        float level = mic.mix.level();
        println(level);
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

        if (!jumping&& level > 0.1) {
          vy = -10;
          jumping = true;
          jumpSound.play();
        }

        if (jumping && yCat < height/index) { 
          vy = 10;
        }
        if (jumping && yCat > height - sizeCat) {
          jumping = false;
          yCat = height - sizeCat;
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
      } else {

        textSize(45);
        text("Game Over", width/3, height/3);
        text("Score", width/3, height/3+ 100);
        text(score, width/3 + 200, height/3 + 100);
        loadStrings("record.txt");
      //   if (myString != null) {
     
    //    if (score > int(bestScore)) {
         saveStrings("record.txt", bestScore);
    //    } 

        textSize(25);
        fill(255);
        text("Say 'Playyy' to play", width/3, height/3 + 200);
      }
    }
  }
}

void checkCollisions() {
  gameOver =false;
  // println(abs(xCat - stones[0].x));
  for (int i = 0; i<stones.size(); i++) {
    if (dist(xCat, yCat, stones.get(i).x, stones.get(i).y)< stones.get(i).size + sizeCat/2) {
      gameOver=true;
      hitSound.play();

      println("collison! gameover");
    }
  }
}
void mouseClicked()
{

  if (mouseButton == LEFT)
  {
    if (gameStart)
    {
      gameStart = false;
    } else if (gameOver)
    {
      reset();
    }
  } else  if (mouseButton == RIGHT)
  {
    paused=!paused;
  }
}

void reset()
{
  //remove object stone from arraylist
  stones.remove(0);
  //stop hitSound
  hitSound.rewind();

  paused=false;
  // set up flag to control the process of game (opening or closing)
  gameOver =false;
  gameStart =true;
  //
  xCat = width/5;
  yCat = height - sizeCat;
  // inisialize all 100 stones 
  int xStone = width + stoneSize;
  for (int i = 0; i < 1; i++) { //stones.size()
    println("reset! for loop");
    stoneSize = floor(random(50, 200));
    println(stoneSize);
    stones.add (new Stone(xStone, height-stoneSize/2, stoneSize)); 
    //stones[i] = new Stone(xStone, height-stoneSize/2, stoneSize); 
    //stoneSize = floor(random(50, 200));
    xStone = xStone+ stones.get(i).size+stoneSize + (int)random(100, 200);
  }
}