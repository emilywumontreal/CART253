//import processing.sound.*;

import gifAnimation.*;
import ddf.minim.*;

Minim minim;
AudioInput mic;
int size = 100;

int bands = 32;

// define an Gif object
Gif loopingGif;
// define the default location of gif object
int x = 0;
int y = height - 100;
int vx = 1;
int vy = 1;
boolean jumping = false;
int index = 1;
int rate = 2;

void setup() {
  size(640, 480);

  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data 
  mic = minim.getLineIn();
  x = width/2 - size/2;
  y = height - size;


  //Changed framerate
  frameRate(20);
  //create the GifAnimation object
  imageMode(CORNER);
  loopingGif = new Gif(this, "rollingcat-maker.gif");

  loopingGif.loop();
}

void draw() {
  background(255, 227, 148);
  float level = mic.mix.level();

  println(level);
  // Adding variable level to adjust the height of cat jumping
  if (level <= 0.1) index = 1;
  if (level > 0.1 && level <=0.2) index = 1*rate;
  if (level > 0.2 && level <=0.3) index = 2*rate;
  if (level > 0.3 && level <=0.4) index = 3*rate;
  if (level > 0.5 && level <=0.9) index = 4*rate;
  if (level > 1.0) index = 5*rate;
  println("index=", index);
  if (!jumping&& level > 0.1) {
    vy = -10;
    jumping = true;
  }

  if (jumping && y < height/index) { 
    vy = 10;
  }
  if (jumping && y > height - size) {
    jumping = false;
    y = height - size;
    vy = 0;
  }
  y += vy;
  image(loopingGif, x, y);
}