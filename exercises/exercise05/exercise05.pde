/*float tx = random(0,100);
 float ty = random(0,100);
 float speed = 10;
 float x;
 float y;
 
 void setup() {
 size(500,500);
 x = width/2;
 y = height/2;
 }
 
 void draw() {
 background(0);
 float vx = speed * (noise(tx) * 2 - 1);
 float vy = speed * (noise(ty) * 2 - 1);
 x += vx;
 y += vy;
 ellipse(x,y,20,20);
 tx += 0.01;
 ty += 0.01;
 
 // Check for wrapping?
 if (x < 0) {
 x += width;
 }
 else if (x > width) {
 x -= width;
 }
 if (y < 0) {
 y += height;
 }
 else if (y > height) {
 y -= height;
 }
 }
 
 
 if (x < 0) {
 x += width;
 }
 else if (x > width) {
 x -= width;
 }
 if (y < 0) {
 y += height;
 }
 else if (y > height) {
 y -= height;
 }
 */
/*noiseDetail(200,0.6);
 size(500, 500);
 
 for (int i = 0; i < width*height; i++) {
 float x = i % width;
 float y = (i / width);
 float n = noise(x/width,y/height);
 color c = color(n * 250);
 stroke(c);
 point(x, y);
 }
 */
/*
float theta = 0;
 int x = 0;
 
 void setup() {
 size(600,600);
 background(0);
 fill(255);
 }
 
 void draw() {
 float y = height/2 + (sin(theta) * height/2);
 ellipse(x,y,10,10);
 x++;
 theta += 0.05;
 }
 */
/*
float theta = 0;
 float size = 300;
 
 void setup() {
 size(600,600);
 background(0);
 fill(255);
 }
 
 void draw() {
 float growth = sin(theta) * (size/4);
 ellipse(width/2,height/2,size + growth,size + growth);
 theta += 0.05;
 } */
/*
float theta = 0;
 
 void setup() {
 size(500,500);
 }
 
 void draw() {
 background(0);
 translate(width/2,height/2);
 rotate(theta);
 rectMode(CENTER);
 rect(0,0,100,100);
 theta += 0.01;
 } */

/*
float theScale = 1;
 
 void setup() {
 size(500,500);
 }
 
 void draw() {
 background(0);
 translate(width/2,height/2);
 scale(theScale);
 rectMode(CENTER);
 rect(0,0,100,100);
 theScale += 0.01;
 } */
// Global angle for rotation

float tx = random(0, 100);
float ty = random(0, 100);
float speed = 10;
float x;
float y;
float theta = 0;

void setup() {
  size(640, 480);
}

void draw() {
  background(0);
  stroke(255);
  // Translate to center of window
  // translate(width/2, height/2);
  // Loop from 0 to 360 degrees (2*PI radians)
  //  for (float i = 0; i < TWO_PI; i += 0.2) {
  // Push, rotate and draw a line!
  //    pushMatrix();
  //    rotate(theta + i);
  //    line(0, 0, 100, 0);
  // From 0 to 360 degrees (2*PI radians)
  //    for (float j = 0; j < TWO_PI; j += 0.5) {
  // Push, translate, rotate!
  //    pushMatrix();
  //    translate(100, 0);
  //   rotate(- theta - j);
  //   line(0, 0, 150, 0);
  // Done with the inside loop, pop!
  // popMatrix();
  // }
  // Done with the outside loop, pop!
  //  popMatrix();
  // }
  // endShape();
  // Increment theta
  theta += 0.01;

  float vx = speed * (noise(tx) * 2 - 1);
  float vy = speed * (noise(ty) * 2 - 1);
  x += vx;
  y += vy;
  // stroke(255);
  ellipse(x, y, 20, 20);
  tx += 0.01;
  ty += 0.01;

  // Check for wrapping?
  if (x < 0) {
    x += width;
  } else if (x > width) {
    x -= width;
  }
  if (y < 0) {
    y += height;
  } else if (y > height) {
    y -= height;
  }
}