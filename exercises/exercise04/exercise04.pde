// Griddies
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// the size of a single bubble element
int bubbleSize = 10;
// An array storing all the griddies
Griddie[] griddies = new Griddie[100];
Bubble[] bubbles = new Bubble[100];


// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // this for loop create 100 griddies by setting a random location for each of them.
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    //println(x);
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  // CHANGED adding a bubble object array
  for (int i = 0; i < bubbles.length; i++) {
    int x = floor(random(0, width/bubbleSize));
    int y = floor(random(0, height/bubbleSize));
    bubbles[i] = new Bubble(x * bubbleSize, y * bubbleSize, bubbleSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // this statement checks if the griddie are not comparing with themselves, if so, go run next loop
      if (j != i) {
      // QUESTION: What does this line check?
      // this line checks if the enery need to be increased or stay the same.
      griddies[i].collide(griddies[j]);
      }
    }

    // Display the griddies
    griddies[i].display();
  }

  // We need to loop through all the bubbles one by one
  for (int i = 0; i < bubbles.length; i++) {

    // Update the griddies
    bubbles[i].update();

    // Now go through all the bubble a second time...
    for (int j = 0; j < bubbles.length; j++) {

      if (j != i) {

        bubbles[i].collide(bubbles[j]);
      }
    }

    // Display the griddies
    bubbles[i].display();
  }
}