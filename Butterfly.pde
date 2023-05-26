/*
Notes: Butterfly wing flapping is 10Hz (1)
 
 
 Generally, drawing of vertices for shapes should be done clockwise
 
 
 References:
 (1) https://www.mdpi.com/2076-3417/11/6/2620
 */


class ButterflyBody {
  float scale;
  color bodyColor;
  ButterflyBody(float inScale, color bColor) {
    scale = inScale;
    bodyColor = bColor;
  }
  
  ButterflyBody(color bColor) {
    this(1.0, bColor);
  }
  

  void drawBody() {
    push();
    fill(bodyColor);
    box(scale* 25,scale* 180,scale* 25);
    pop();
  }
}

class ButterflyWing {
  float scale;
  int side;
  color wingColor;

  ButterflyWing(float scaleIn, boolean sideIn, color wColor) {
    scale = scaleIn;
    side = int(sideIn) * 2 - 1; // 1,0 -> -1,1 ==> Left,Right  BUG_POTENT
    wingColor = wColor;
  }
  ButterflyWing(color wColor) {
    this(1.0, false, wColor);
  }
  

  void drawWing(float flapAngle) {
    // draw top
    push();
      rotateY(side* flapAngle); // add rotation for wings
      fill(side < 0 ? wingColor : #FFFFFF);
      beginShape();
        vertex(0, 0, 0);
        vertex(side* scale* -230, scale* 10, 0);
        vertex(side* scale* -315, scale* -170, 0);
        vertex(side* scale* -120, scale* -150, 0);
        vertex(side* scale* 0, scale* -30, 0);
      endShape();
      // draw bottom
      beginShape();
        vertex(0, 0, 0);
        vertex(side* scale* -15, scale* 140, 0);
        vertex(side* scale* -65, scale* 195, 0);
        vertex(side* scale* -115, scale* 200, 0);
        vertex(side* scale* -200, scale* 145, 0);
        vertex(side* scale* -215, scale* 55, 0);
        vertex(side* scale* -170, scale* 15, 0);
      endShape();
    pop();
  }
  
  /* For debugging, sets at fixed angle.*/
  void drawWing() {
    drawWing(0.0);
  }
}



class Butterfly {
  float scale;
  color wingColor;
  color bodyColor;
  ButterflyBody body;
  ButterflyWing wingL, wingR;
  float flapAngle;
  float flapMax = PI/2;
  float flapMin = -PI/2 + PI/8;
  float flapA = (flapMax - flapMin)/2;
  float flapC = (flapMax + flapMin)/2;
  float flapRate = 2;
  float time; // time since spawn
  float initTime; // starting time stamp when butterfly is spawned
  Butterfly(float inScale, color wColor, color bColor) {
    scale = inScale;
    wingColor = wColor;
    bodyColor = bColor;
    
    wingL = new ButterflyWing(scale, true, wingColor); // BUG_POTENT
    wingR = new ButterflyWing(scale, false, wingColor); // BUG_POTENT
    body = new ButterflyBody(scale, bodyColor);
    
    flapAngle = flapMax;
    initTime = millis();
    time = millis() - initTime;
  }
  
  void adjustWingAngle() {
    time = millis() - initTime;
    flapAngle = flapA * cos(2*PI*flapRate * (time/1000)) + flapC;
    println(flapAngle);
  }
  
  void sketch() {
    body.drawBody();
    push();
      translate(0, - scale* 20, 0); // adjust wing vertical position
      push();
        translate(- scale * 12,0,0); // adjust wing horizontal position
        wingL.drawWing(flapAngle);
      pop();
      push();
        translate(scale *12, 0, 0); // adjust wing horizontal position
        wingR.drawWing(flapAngle);
      pop();
    pop();
  }

  
}
