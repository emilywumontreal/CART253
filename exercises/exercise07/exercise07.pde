import processing.sound.*;
import gifAnimation.*;

PImage[] animation;
Gif loopingGif;
Gif nonLoopingGif;
boolean pause = false;

AudioIn mic;

FFT fft;
int bands = 32;

void setup() {
  size(680, 420);

  // Create an audio input and grab the first channel
  mic = new AudioIn(this, 0);
  // Start the audio Input
  mic.start();

  fft = new FFT(this, bands);
  fft.input(mic);

  // create the GifAnimation object for 
  imageMode(CENTER);
  
  loopingGif = new Gif(this, "rollingeyescat.gif");
  loopingGif.setSize(20,20);
  loopingGif.loop();
}

void draw() {
  background(255);
  fft.analyze();
  //start moving a gif pic,following the sound level 
  
  for (int i = 0; i < fft.size(); i++) {
    float y = map(fft.spectrum[i], 0, 0.5, height * 0.75, 0);
    image(loopingGif, width/2, height - loopingGif.height);
  }
    
}