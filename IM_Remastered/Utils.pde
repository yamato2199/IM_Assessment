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
      //Piano
      GM_Instruments[0] = "Acoustic Grand Piano";
      GM_Instruments[1] = "Bright Acoustic Piano";
      GM_Instruments[2] = "Electric Grand Piano";
      GM_Instruments[3] = "Electric Grand Piano";
      GM_Instruments[4] = "Honky-tonk Piano";
      GM_Instruments[5] = "Electric Piano 1";
      GM_Instruments[6] = "Electric Piano 2";
      GM_Instruments[7] = "Harpsichord";
      GM_Instruments[8] = "Clavinet";
      //Chromatic Percussion
      GM_Instruments[9] = "Celesta";
      GM_Instruments[10] = "Glockenspiel";
      GM_Instruments[11] = "Music Box";
      GM_Instruments[12] = "Vibraphone";
      GM_Instruments[13] = "Marimba";
      GM_Instruments[14] = "Xylophone";
      GM_Instruments[15] = "Tubular Bells";
      GM_Instruments[16] = "Dulcimer";
      //Organ
      GM_Instruments[17] = "Drawbar Organ";
      GM_Instruments[18] = "Percussive Organ";
      GM_Instruments[19] = "Rock Organ";
      GM_Instruments[20] = "Church Organ";
      GM_Instruments[21] = "Reed Organ";
      GM_Instruments[22] = "Accordion";
      GM_Instruments[23] = "Harmonica";
      GM_Instruments[24] = "Tango Accordion";
      //Guitar
      GM_Instruments[25] = "Acoustic Guitar (nylon)";
      GM_Instruments[26] = "Acoustic Guitar (steel)";
      GM_Instruments[27] = "Electric Guitar (jazz)";
      GM_Instruments[28] = "Electric Guitar (clean)";
      GM_Instruments[29] = "Electric Guitar (muted)";
      GM_Instruments[30] = "Overdriven Guitar";
      GM_Instruments[31] = "Distortion Guitar";
      GM_Instruments[32] = "Guitar Harmonics";
      //Bass
      GM_Instruments[33] = "Acoustic Bass";
      GM_Instruments[34] = "Electric Bass (finger)";
      GM_Instruments[35] = "Electric Bass (pick)";
      GM_Instruments[36] = "Fretless Bass";
      GM_Instruments[37] = "Slap Bass 1";
      GM_Instruments[38] = "Slap Bass 2";
      GM_Instruments[39] = "Synth Bass 1";
      GM_Instruments[40] = "Synth Bass 2";
      //Strings
      GM_Instruments[41] = "Violin";
      GM_Instruments[42] = "Viola";
      GM_Instruments[43] = "Cello";
      GM_Instruments[44] = "Contrabass";
      GM_Instruments[45] = "Tremolo Strings";
      GM_Instruments[46] = "Pizzicato Strings";
      GM_Instruments[47] = "Orchestral Harp";
      GM_Instruments[48] = "Timpani";
      //Ensemble
      GM_Instruments[49] = "String Ensemble 1";
      GM_Instruments[50] = "String Ensemble 2";
      GM_Instruments[51] = "Synth Strings 1";
      GM_Instruments[52] = "Synth Strings 2";
      GM_Instruments[53] = "Choir Aahs";
      GM_Instruments[54] = "Voice Oohs";
      GM_Instruments[55] = "Synth Choir";
      GM_Instruments[56] = "Orchestra Hit";
      //Brass
      GM_Instruments[57] = "Trumpet";
      GM_Instruments[58] = "Trombone";
      GM_Instruments[59] = "Tuba";
      GM_Instruments[60] = "Muted Trumpet";
      GM_Instruments[61] = "French Horn";
      GM_Instruments[62] = "Brass Section";
      GM_Instruments[63] = "Synth Brass 1";
      GM_Instruments[64] = "Synth Brass 2";
      //Reed
      GM_Instruments[65] = "Soprano Sax";
      GM_Instruments[66] = "Alto Sax";
      GM_Instruments[67] = "Tenor Sax";
      GM_Instruments[68] = "Baritone Sax";
      GM_Instruments[69] = "Oboe";
      GM_Instruments[70] = "English Horn";
      GM_Instruments[71] = "Bassoon";
      GM_Instruments[72] = "Clarinet";
      //Pipe
      GM_Instruments[73] = "Piccolo";
      GM_Instruments[74] = "Flute";
      GM_Instruments[75] = "Recorder";
      GM_Instruments[76] = "Pan Flute";
      GM_Instruments[77] = "Blown bottle";
      GM_Instruments[78] = "Shakuhachi";
      GM_Instruments[79] = "Whistle";
      GM_Instruments[80] = "Ocarina";
      //Synth Lead
      GM_Instruments[81] = "Lead 1 (square)";
      GM_Instruments[82] = "Lead 2 (sawtooth)";
      GM_Instruments[83] = "Lead 3 (calliope)";
      GM_Instruments[84] = "Lead 4 (chiff)";
      GM_Instruments[85] = "Lead 5 (charang)";
      GM_Instruments[86] = "Lead 6 (voice)";
      GM_Instruments[87] = "Lead 7 (fifths)";
      GM_Instruments[88] = "Lead 8 (bass + lead)";
      //Synth Pad
      GM_Instruments[89] = "Pad 1 (new age)";
      GM_Instruments[90] = "Pad 2 (warm)";
      GM_Instruments[91] = "Pad 3 (polysynth)";
      GM_Instruments[92] = "Pad 4 (choir)";
      GM_Instruments[93] = "Pad 5 (bowed)";
      GM_Instruments[94] = "Pad 6 (metallic)";
      GM_Instruments[95] = "Pad 7 (halo)";
      GM_Instruments[96] = "Pad 8 (sweep)";
      //Synth Effects
      GM_Instruments[97] = "FX 1 (rain)";
      GM_Instruments[98] = "FX 2 (soundtrack)";
      GM_Instruments[99] = "FX 3 (crystal)";
      GM_Instruments[100] = "FX 4 (atmosphere)";
      GM_Instruments[101] = "FX 5 (brightness)";
      GM_Instruments[102] = "FX 6 (goblins)";
      GM_Instruments[103] = "FX 7 (echoes)";
      GM_Instruments[104] = "FX 8 (sci-fi)";
      //Ethnic
      GM_Instruments[105] = "Sitar";
      GM_Instruments[106] = "Banjo";
      GM_Instruments[107] = "Shamisen";
      GM_Instruments[108] = "Koto";
      GM_Instruments[109] = "Kalimba";
      GM_Instruments[110] = "Bagpipe";
      GM_Instruments[111] = "Fiddle";
      GM_Instruments[112] = "Shanai";
      //Percussive
      GM_Instruments[113] = "Tinkle Bell";
      GM_Instruments[114] = "Agogo";
      GM_Instruments[115] = "Steel Drums";
      GM_Instruments[116] = "Woodblock";
      GM_Instruments[117] = "Taiko Drum";
      GM_Instruments[118] = "Melodic Tom";
      GM_Instruments[119] = "Synth Drum";
      GM_Instruments[120] = "Reverse Cymbal";
      //Sound effects
      GM_Instruments[121] = "Guitar Fret Noise";
      GM_Instruments[122] = "Breath Noise";
      GM_Instruments[123] = "Seashore";
      GM_Instruments[124] = "Bird Tweet";
      GM_Instruments[125] = "Telephone Ring";
      GM_Instruments[126] = "Helicopter";
      GM_Instruments[127] = "Applause";
      GM_Instruments[128] = "Gunshot";
      //.....
      
      return GM_Instruments[programNumber] == null ? programNumber+"" : GM_Instruments[programNumber];
  }
}
