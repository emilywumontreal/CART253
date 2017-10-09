// main program of exercise03
// initialize the value of backgroundColor and declaire two instances of class Bouncer
// call function setup() and draw() to create two instances of Bouncer and draw shape on the canvas  
color backgroundColor = color(200, 150, 150);
Bouncer bouncer;
Bouncer bouncer2;
// function setup()
//
// setup the canvas size and background and make 2 instances of class Bouncer
void setup() {
  size(640, 480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2, height/2, 2, 2, 50, color(150, 0, 0, 50), color(255, 0, 0, 50));
  bouncer2 = new Bouncer(width/2, height/2, -2, 2, 50, color(0, 0, 150, 50), color(0, 0, 255, 50));
}
// function draw()
//
// call bouncer's methods.
void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}
// CHANGED new function mouseClicked()
void mouseClicked() {
  bouncer.decreaseSize();
}