// Types of piano keys
class PianoKey {

  PVector pos;
  color keyColor;
  public float keyLen, keyWid;
  public int pitch;
  boolean isPressed = false;

  PianoKey(PVector pos, color keyColor, float keyLen, float keyWid, int pitch) {
    this.pos=pos;
    this.keyColor=keyColor;
    this.keyLen=keyLen;
    this.keyWid=keyWid;
    this.pitch=pitch;
    delay(50);

  }
  

  void press() {
    fill(#FCAD36, 80);
    if (keyColor==color(#FFFFFF)) {
      rect(pos.x, pos.y, keyLen, keyWid, 1, 1, 1, 1);
    }
    else {
      rect(pos.x, pos.y, keyLen, keyWid, 1, 8, 8, 1);
    }
    isPressed = true;
  }
  void unpress() {
    isPressed = false;
  }
  void show() {
    fill(keyColor);
    strokeWeight(2);
    if (keyColor==color(#FFFFFF)) {
      rect(pos.x, pos.y, keyLen, keyWid, 1, 1, 1, 1);
    }
    else {
      rect(pos.x, pos.y, keyLen, keyWid, 1, 8, 8, 1);
    }
  }
}
