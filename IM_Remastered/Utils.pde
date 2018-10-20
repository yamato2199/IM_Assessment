/*
  Helper class
*/
public static class Utils {
  
 
  public static float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
    float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
    return d;
  }
 
  public static String NumberToMIDIInstrument(int programNumber) {
      String GM_Instruments[] = new String[128];
      //Setup MIDI Intrucment lookup Table
      GM_Instruments[0] = "Acoustic Grand Piano";
      GM_Instruments[1] = "Bright Acoustic Piano";
      GM_Instruments[2] = "Electric Grand Piano";
      GM_Instruments[3] = "Electric Grand Piano";
      GM_Instruments[4] = "Honky-tonk Piano";
      GM_Instruments[5] = "Electric Piano 1";
      GM_Instruments[6] = "Electric Piano 2";
      GM_Instruments[7] = "Harpsichord";
      GM_Instruments[8] = "Clavinet";
      //.....
      
      return GM_Instruments[programNumber] == null ? programNumber+"" : GM_Instruments[programNumber];
  }
}
