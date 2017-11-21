import processing.sound.*;
import processing.pdf.*;
import gifAnimation.*;

AudioIn mic;

FFT fft;
int bands = 32;

// define an Gif object
Gif loopingGif;
// define the default location of gif object
int x = width/2;
int y = height - 100;

void setup() {
  size(512, 360);

  // Create an audio input and grab the first channel
  mic = new AudioIn(this, 0);
  // Start the audio Input
  mic.start();

  fft = new FFT(this, bands);
  fft.input(mic);


  //Changed framerate
  frameRate(20);
  //create the GifAnimation object for 
  imageMode(CORNER);

  loopingGif = new Gif(this, "rollingcat-maker.gif");
  //loopingGif.setSize(20, 20);
  loopingGif.loop();
}

void draw() {
  background(255);
  fft.analyze();
  for (int i = 0; i < fft.size(); i++) {
    float y = map(fft.spectrum[i], 0, 0.5, height * 0.75, 0);
    println("y= "+ y);
    noStroke();
    fill(int(200/bands)*i);
    rect((width/bands)*i, y, (width/bands)*(i+1), height);
    if (y < 269.9 || y > 269.7) {
      image(loopingGif, x, height - y);
    }
  }
}