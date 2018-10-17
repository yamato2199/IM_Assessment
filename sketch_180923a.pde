import processing.video.*;
import java.lang.Math;
/*========================================*/
import themidibus.*;
/*========================================*/
MidiBus myBus;
int currentPitch = 0;
/*========================================*/
int playWidth=100;  // The width of the piano playing area
PianoKey[] whiteKeys, blackKeys;
int numKeys=41;  // Number of key(odd)
float keyWidth; 
//==================================
ParticleSystem ps;
float x=0;
float y=0;
float speed = 1;
float a =0;

Capture video;
PImage prev;
color trackColor; 
float threshold = 40;
/*========================================*/
void setup() {
  
  size(640, 360);
  
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[3]);
  video.start();
  prev = createImage(video.width, video.height, RGB);
  trackColor = color(255,0,0);
  //----------
  whiteKeys=new PianoKey[(numKeys+1)/2];
  blackKeys=new PianoKey[(numKeys-1)/2];
  keyWidth=(float)height/whiteKeys.length;
  initKeys();
  //----------
  ps = new ParticleSystem(new PVector(x, y));
  a = (float)(height*4)/(float)(width * width);
  
  /*===========================*/
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, -1, "FluidSynth virtual port (909)"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  
  video.loadPixels();
  image(video, 0, 0);

  //threshold = map(mouseX, 0, width, 0, 100);
  threshold = 150;
  
  float avgX = 0;
  float avgY = 0;

  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {
        stroke(255);
        strokeWeight(1);
        point(x, y);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 24, 24);
  }
  
  
  ps.setPos(avgX, avgY);
  ps.addParticle();
  showKeys();
  ps.run();
  
  /*===========================*/
  int channel = 0;
  int pitch = (int)map(avgY,0,height,21,108); //MIDI key A0 -> C8
  if(currentPitch == pitch) return;
  currentPitch = pitch;
  
  

  int cc = 0;
  int value = 80;

  myBus.sendControllerChange(channel,cc , value); // Send a controllerChange
  delay(50);
  PVector pos=new PVector(-100,-100);
  if ( play().score>0) {
    // Play the piano
    play().getPitch();
    pos=new PVector(play().pos.x+play().keyLen/2+random(30), play().pos.y);
  }
}


void initKeys() {
  // Initial white keys
  for (int i=0; i<whiteKeys.length; i++) {
    whiteKeys[i]=new PianoKey(new PVector(keyWidth*144/24/2, keyWidth/2+i*keyWidth), 
      color(#FFFFFF), keyWidth*144/24, keyWidth, i+1);
  }

  // Initial black keys
  for (int i=0; i<blackKeys.length; i++) {
    blackKeys[i]=new PianoKey(new PVector(keyWidth*86/24/2, (i+1)*keyWidth), 
      color(#000000), keyWidth*86/24, keyWidth*9/24, i+1);
  }
}

void showKeys() {
  // Initial white keys
  for (int i=0; i<whiteKeys.length; i++) {
    whiteKeys[i].show();
  }

  // Initial black keys
  for (int i=0; i<blackKeys.length; i++) {
    blackKeys[i].show();
  }
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}



class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }
  void setPos(float x, float y) {
     origin = new PVector(x,y); 
  }
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 1, 1);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

/*===========================*/
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

PianoKey play() {
  PianoKey pressKey=whiteKeys[0];
  for (PianoKey pk : whiteKeys) {
    if (pressKey.score<pk.score) {
      pressKey=pk;
    }
  }
  return pressKey;
}
