float tx = random(0, 100);
float ty = random(0, 100);
int b = 0;
int r = 0;
int g = 0;
void setup() {
  frameRate(2);
  size(500, 500);
  // CHANGED set window resize trigger on
  surface.setResizable(true);
}

void draw() {
  //background(0);
  // CHANGED adding random background color by using %
  background(r, g, b);
  b = (b + 1) % 255;
  r = (r + 1) % 255;
  g = (g + 2) % 255;

  //CHANGED adding a for loop to draw 10000 times ellipses at a random position in the same frame
  for (int i = 0; i< 100; i++) {
    float x = width * noise(tx);
    float y = height * noise(ty);
    // CHANGED making a random stroke color for the ellipse
    float n = noise(x/width, y/height);
    //println(n);
    color c = color(n * 255);
    fill(c);
    ellipse(x, y, 20, 20);
    tx += 0.01;
    ty += 0.01;
    // CHANGED adding a possibility checker to resize window to specific size.
    if (n < 0.5) {
      surface.setSize(624,480);
     } else if (n < 0.8) {
      surface.setSize(480,624);
    } else {
      surface.setSize(500,500);
    }
    
  }
}