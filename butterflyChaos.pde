/*PVector v1, v2;*/
//ButterflyWing wingTest1 = new ButterflyWing(color(#FFFFFF));
ButterflyWing wingTest1 = new ButterflyWing(1.0, true, color(255, 255, 0));
ButterflyWing wingTest2 = new ButterflyWing(1.0, false, color(255, 255, 0));
ButterflyBody bodyTest = new ButterflyBody(1.0, color(200, 200, 200));

color wingColor = color(255, 255, 0);
color bodyColor = color(200, 200, 200);

Butterfly butterflyTest = new Butterfly(0.5, wingColor, bodyColor);

float ix,iy,iz;
void setup() {
  size(640, 360, P3D);
  background(0);
  lights();
  ix = width/2;
  iy = height/2;
  iz = 0;
  
}

void draw() {
  background(0);
  translate(ix, iy,iz);
  rotateY(PI/8);
  rotateX(PI/8);
  //box(100, 100, 100);
  //wingTest1.drawWing();
  //wingTest2.drawWing();
  //bodyTest.drawBody();
  butterflyTest.adjustWingAngle();
  
  butterflyTest.sketch();
  //print(millis());
  
  
}
