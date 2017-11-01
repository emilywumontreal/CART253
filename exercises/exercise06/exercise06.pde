// Exercise 06
//
// Using the webcam as input to play with Bouncers.

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector brightestPixel = new PVector(-1, -1);

// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[10];

// CHANGED adding a targetColor to decide what color the bouncer will be
color targetColor = 0;

// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-10, 10), random(-10, 10), random(20, 50), color(random(255)));
  }

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
}

// draw()
//
// Processes the frame of video, draws the video to the screen, updates the Bouncers
// and then just draws an ellipse at the brightest pixel location. You code should
// do something much more interesting in order to actually interact with the Bouncers.

void draw() {


  // A function that processes the current frame of video
  handleVideoInput();

  // Draw the video frame to the screen
  image(video, 0, 0);

  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.

  // CHANGED adding a condition if brightest pixel are inside of rightbottom coner of the window, the boncers are not showing up , otherwise the bouncers will show.
  if (brightestPixel.x < width/2 || brightestPixel.y <= height/2) {
    //println(brightestPixel.x);
    //println(brightestPixel.y);
    for (int i = 0; i < bouncers.length; i++) {
      //CHANGED change bouncer's color by the input image color.
      bouncers[i].fillColor = targetColor;
      
      bouncers[i].update();
      bouncers[i].display();
    }
  } 

  // For now we just draw a crappy ellipse at the brightest pixel
  //fill(#ff0000);
  //CHANGED ellipse color will be filled with the targetColor 
  fill(targetColor);
  stroke(#ffff00);
  //CHANGED strokeWeight to 1 instead of 10
  strokeWeight(1);
  ellipse(brightestPixel.x, brightestPixel.y, 20, 20);
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the brightest pixel
// in that frame and stores its location in brightestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float brightnessRecord = 0;
  // CHANGED adding variables to record red, green and blue color
  int r = 0;
  int g = 0;
  int b = 0;
  int myColor = 0;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the brightness of the pixel we're looking at
      float pixelBrightness = brightness(pixelColor);
      //CHANGED  to find the input image are more red or yellow or blue.
      myColor = get(mouseX, mouseY);
      targetColor = 0;
      if (red(myColor) > blue(myColor)&& red(myColor) > green(myColor) )  r += 1;
      if (blue(myColor) > red(myColor)&& blue(myColor) > green(myColor) ) b += 1;
      if (green(myColor) > red(myColor)&& green(myColor) > blue(myColor) ) g += 1;
      
      // Check if this pixel is the brighest we've seen so far
      if (pixelBrightness > brightnessRecord) {
        // If it is, change the record value
        brightnessRecord = pixelBrightness;
        // Remember where this pixel is in the the grid of pixels
        // (and therefore on the screen) by setting the PVector
        // brightestPixel's x and y properties.
        brightestPixel.x = x;
        brightestPixel.y = y;
      }
    }
  }
  if (r > g && r > b) targetColor = color(255, 0, 0, 70);
  if (g > r && g > b) targetColor = color(0, 255, 0, 70);
  if (b > r && b > g) targetColor = color(0, 0, 255, 70);
}