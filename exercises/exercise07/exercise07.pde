import processing.sound.*;
//import gifAnimation.*;

//PImage[] animation;
//Gif loopingGif;
//Gif nonLoopingGif;
//boolean pause = false;
int x;
int y;

AudioIn mic;

FFT fft;
int bands = 32;

void setup() {
  size(780, 650);
  frameRate(10);
  // Create an audio input and grab the first channel
  mic = new AudioIn(this, 0);
  // Start the audio Input
  mic.start();

  fft = new FFT(this, bands);
  fft.input(mic);

  // create the GifAnimation object for 
  // imageMode(CORNER);

  // loopingGif = new Gif(this, "rollingeyescat.gif");
  // loopingGif.setSize(20,20);
  // loopingGif.loop();
  x = width/2;//- loopingGif.width/2;
  y = height;//+ loopingGif.height;

  // setting up a brush
  noFill();
  stroke(0);
  strokeWeight(20);
}

void draw() {
  background(255);
  fft.analyze();
  for (int i = 0; i < fft.size(); i++) {
    float y = map(fft.spectrum[i], 0, 0.5, 0, 100);
    //if (y > 1) 
    //{
    //  image(loopingGif, x, height - y);
    //}
    fill(255, 0, 0);
    //ellipse(x, y, 10, 10);
    println(x, y);
    // new idea on representing the level of sound
    float size = 300.0 * y;
    ellipse(width/ 2.0, height / 2.0, size, size);
  }
}