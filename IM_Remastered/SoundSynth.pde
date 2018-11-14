import themidibus.*;
MidiBus myBus;

class SoundSynth {
  int noteDelay;
  public SoundSynth(int inputIndex,int noteDelay){
    MidiBus.list();
    myBus = new MidiBus(this, -1, inputIndex);
    this.noteDelay = noteDelay;
  }
  
  public void play(int pitch,int program) {
    int PROGRAM_CHANGE_STAUTS = 0xC0;
    myBus.sendMessage(PROGRAM_CHANGE_STAUTS, 0, program, 0); 
    myBus.sendNoteOn(0,pitch,127);
    //delay(noteDelay);
    myBus.sendNoteOff(0,pitch,127);
    
    //myBus.sendControllerChange(0,0 , 80); // Send a controllerChange
    //delay(50);
  }

}
