import processing.sound.*;

AudioIn mic;

FFT fft;
int bands = 32;

void setup() {
  size(512, 360);

  // Create an audio input and grab the first channel
  mic = new AudioIn(this, 0);
  // Start the audio Input
  mic.start();

  fft = new FFT(this, bands);
  fft.input(mic);
}

void draw() {
  background(255);
  fft.analyze();
  //start moving a gif pic ,following the sound level 
  for (int i = 0; i < fft.size(); i++) {
    float y = map(fft.spectrum[i], 0, 0.5, height * 0.75, 0);
   
  }
}