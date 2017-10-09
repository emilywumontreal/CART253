// definition of class Bouncer
// build a constructor of class Bouncer
// name the variables, parameters and methods in class Bouncer 

class Bouncer {
 // variables of class Bouncer 
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 // constructor of class including 6 parameters, which are receiving from the caller by using reserved word 'new'.
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
// function update()
//
// update the position of the bouncer move and respose the action of mouse.
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
   handleMouse();
 }
 // function handleBounce
 //
 // judge the location of bouncer: if it is out of window, set it back and remain the bouncer inside of window
 void handleBounce() {
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 // function handleMouse()
 //
 // change color if mouse inside of the bouncer
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 // function draw()
 //
 // draw a bouncer without stroke, with a specific color and size
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}