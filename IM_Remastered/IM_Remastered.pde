import processing.video.*;
import java.lang.Math;
Capture video;
PImage prev;
///////MIDI///////
int noteDelay = Config.NOTE_DELAY;
SoundSynth synth;
int pitch;
int currentInstrument = 0;
//////////////////
////// PIANO KEY ///////
int playWidth=Config.PLAY_WIDTH;  // The width of the piano playing area
PianoKey[] whiteKeys, blackKeys;
int numKeys=Config.TOTAL_KEYS;  // Number of key(odd)
float keyWidth; 
///////////////////////
/////// Effects ///////
ParticleSystem particleSystem;
PImage particleImg; //Image used for create particle effect
PGraphics particleGraphic;
PVector particlePos = new PVector(0,0);
void setup() {
   size(640, 360);
   setupCamera();
   prev = createImage(video.width, video.height, RGB);
   setupPianoKey();
   setupSound();
   setupParticleEffect();
}

void draw(){
   renderCamera(video);
   int currentY = trackPoint(video,color(255,0,0),130);
   int currentY2 = trackPoint(video,color(0,0,255),130);
   //testGenerateByMouse();
   renderPianoKeys();
   triggerhitKeys(currentY);
   triggerhitKeys(currentY2);
   renderParticleEffect();
   renderUI();
}

void mouseClicked() {
  //Deal with MIDI program change (which will change the current instrument)
  switch(mouseButton) {
     case LEFT: 
       currentInstrument+=1;
       break;
     case RIGHT:
       currentInstrument-=1;
       break;
     default:
       currentInstrument+=1;
       break;
  }
  if(currentInstrument>127) 
      currentInstrument = 0;
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      currentInstrument-=8;
    } else if (keyCode == RIGHT) {
      currentInstrument+=8;
     
    } 
  } 
 if(currentInstrument>127) 
      currentInstrument = 0;
 if(currentInstrument<0) 
      currentInstrument = 127;
}


void setupCamera() {
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[3]);
  video.start();
} 

void renderCamera(Capture video) {
  video.loadPixels();
  image(video, 0, 0);
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

int trackPoint(Capture video,color trackColor,float threshold) {
    int currentY = 0;
    float avgX = 0; float avgY = 0;
    int count = 0;
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

      float d = Utils.distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {
        /*
        stroke(255);
        point(x, y);
        */
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 24, 24);
    currentY = (int)avgY;
  }
  return currentY;
}
void testGenerateByMouse() {
    int newPitch = (int)map(mouseY,0,height,21,108);
    if(newPitch < 108) newPitch+=2;
    //Ensure there's no duplucated sound
    if(newPitch != pitch) {
      synth.play(pitch,currentInstrument); 
      pitch = newPitch;
    }
    
}
void setupSound() {
  synth = new SoundSynth(2,noteDelay);
}
void synthSound(int currentPitch) {
    int newPitch = currentPitch;
    if(newPitch < 108) newPitch+=2;
    //Ensure there's no duplucated sound
    if(newPitch != this.pitch) {
      synth.play(pitch,currentInstrument); 
      this.pitch = newPitch;
    }
}
void setupPianoKey(){
  whiteKeys=new PianoKey[(numKeys+1)/2];
  blackKeys=new PianoKey[(numKeys-1)/2];
  keyWidth=(float)height/whiteKeys.length;
  //Key setup
   // Initial white keys
  for (int i=0; i<whiteKeys.length; i++) {
    whiteKeys[i]=new PianoKey(new PVector((keyWidth*144/24/2)-50, (keyWidth/2+i*keyWidth)-10), 
      color(#FFFFFF), keyWidth*144/24, keyWidth, 101-i);
  }

  // Initial black keys
  for (int i=0; i<blackKeys.length; i++) {
    blackKeys[i]=new PianoKey(new PVector((keyWidth*86/24/2)-50, ((i+1)*keyWidth)-5), 
      color(#000000), keyWidth*86/24, keyWidth*9/24, i+1);
  }
  
}

void renderPianoKeys(){
  // Initial white keys
  for (int i=0; i<whiteKeys.length; i++) {
    whiteKeys[i].show();
  }

  // Initial black keys
  for (int i=0; i<blackKeys.length; i++) {
    blackKeys[i].show();
  }

}

void triggerhitKeys(int currentY) {
  if(currentY == 0) { 
    particlePos = new PVector(0,0); 
    return;
  }
  for (PianoKey pk : whiteKeys) {
    if (currentY > pk.pos.y && currentY < pk.pos.y+pk.keyWid) {
      //Apply Sound Synth
      synthSound(pk.pitch);
      //Pressed key color change
      pk.press();
      //Particle Effect
      if(Config.ENABLE_PARTICLE) particlePos = new PVector(pk.pos.x + pk.keyLen,pk.pos.y);
    }
  }
 
}

void setupParticleEffect() {
    particleGraphic = createGraphics(width, height);
    particleImg =loadImage(Config.PARTICLE_IMG_NAME);
    particleSystem = new ParticleSystem(0, new PVector(0, 0),particleImg,particleGraphic);
}
void renderParticleEffect() {
    applyParticleEffect(particlePos);
}
void applyParticleEffect(PVector pos){
  particleGraphic.beginDraw();
  particleGraphic.background(0, 10);
  particleSystem.origin=pos;
  PVector wind = new PVector(0, 0);
  particleSystem.applyForce(wind);
  particleSystem.run();
  if(!pos.equals(new PVector(0,0))) {
    for (int i = 0; i < 15; i++) {
      particleSystem.addParticle();
    }
  }
  particleGraphic.endDraw();
  image(particleGraphic, 0, 0);
}

void renderUI() {
  fill(255,255,255);
  textSize(20);
  text("Instrument Class:"+Utils.NumberToMIDIInstrumentClass(currentInstrument) +"\nInstrument: "+ Utils.NumberToMIDIInstrument(currentInstrument) , width-520, 30); 
  textSize(13);
  text("Hint: < & > change instrument class\nmouse right & left change instrument",width-250, height-30);
}
