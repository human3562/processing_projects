float legspace = HALF_PI;
float a;
float aH;
float aL;
float aB;
float t = 10;
float zero = 0;
float desired = 0;
void setup() {
  size(600, 600);
  loadImages();
  imageMode(CENTER);
}

void draw() {
  float eTime = 1/frameRate;
  background(255);
  stroke(255, 0, 0);
  line(width/2, height/2, mouseX, mouseY);
  pushMatrix();
  translate(width/2, height/2);
  a = atan2(mouseY - height/2, mouseX - width/2);
  if (a<0) a += TWO_PI;
  aH = lerp(aH, a, t*eTime);
  if ((aH-aL)%TWO_PI>legspace) aL = aH-legspace;
  else if ((aH-aL)%TWO_PI<-legspace) aL = aH + legspace;
  aB = ((aH-aL))/-2+aH;



  pushMatrix();
  rotate(aL);
  image(toes, 0, 0);
  popMatrix();

  pushMatrix();
  rotate(aB);
  image(body, 0, 0);
  popMatrix();

  pushMatrix();
  rotate(aH);
  image(head, 0, 0);
  popMatrix();

  popMatrix();
  fill(0);
  text("FPS: "+frameRate, 10, 10);
  text("Head angle: "+ aH, 10, 25);
  text("Body angle: "+ aB, 10, 40);
  text("Legs angle: "+ aL, 10, 55);
}
