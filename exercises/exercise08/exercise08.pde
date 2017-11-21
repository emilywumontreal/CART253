import processing.sound.*;
import processing.pdf.*;
import gifAnimation.*;

AudioIn mic;

FFT fft;
int bands = 32;

// define an Gif object
Gif loopingGif;
// define the default location of gif object
int x = 0;
int y = height - 100;
int vx = 1;

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
    // adding 
    // if (y * 10 % 2600 <= 99 || y * 10 % 2600 >= 60) {

    println("cat location y is ", int(abs(y*10 % 2600 - height)));
    println("cat location x is ", x); //int(x*10 %2600
   
    //  } else if (y * 10 % 2600 <= 59 || y * 10 % 2600 >= 30) {
    //image(loopingGif, x, height - y*10 % 2600);
    //  }
    
   
    
  }
   if (x < width && x > 0) {
     x += vx;
    } else x = 0; //loopingGif.width/2; 
    
        image(loopingGif, x, 250);

}