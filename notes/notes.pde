// xiaojie wu
// notes 10-23-2017
// subject MATH
// modulo
/*
  0 % 5 = 0
  3 % 5 = 3
  sequence means something
  int blueness = 0;
  void draw () {
    background(0, 0, blueness);
    blueness = (blueness + 1 ) % 255;
  
      rect(width/2,height/2, sizes[i], sizes[i]);
      i = (i+1)% sizes.length;
       random function always give the same sequence of numbers with same randomseed.
       
       game design mode: possibilities
       if (value < 0.01) else if (value < 0.6) else if ( <0.16)
        timeless noise(time) function
        noise time is changing.
        float n = noise(t);
        random(0,1);
        // drawing a curval line ramdomly
        ellipse(x,n*height,5,5);
        x++;
        t += 0.01;
        
        float vx = speed * (noise(tx)*2 -1);
        ty;
        // CGI
        noiseDetail(16, 0.6);
        size(500,500);
        CGI game effect;
  }
  recursion di gui
  fractal
  mandel
  //
  // Geometry tricks
  
  radians(90) = 1.5( PI/2);
  degrees(PI) = 180;
  oscillated // swing
  
  y = height/2 + (sin(theta)*height*2);
  theta +=0.08;
  
  match to behiviors and mood and emitions
  
  rotateX rotateY from the top left conner everthing after the translate being written
  radians();
  
  use this with roate scaling(2) 2 times of object;
  
  size (12,13, P3D);
  box(60);
  )  
  setup() {surface.setResizable(true);}

  surfacesetSize(200,300);
  millis(); //timer
  if key == 'x' 
  (millis() - startTime)/1000
  
  Nov 6th notes:
  
    tones[] = song[songIndex];
songindex = (songindex + 1) % song.length;
sine.freq(440);
sine.freq(map(mousex,0,width,1,880));
SawOsc 
PinkNoise(this);
music generator?
WhiteNoise(this);
new SinOsc(this);

script src = processing.min.org
<canvas data-procesing-sources = "Pond.pde Paddle.pde Ball.pde"

*/