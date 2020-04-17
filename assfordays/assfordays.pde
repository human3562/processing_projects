ArrayList<hero> heroes = new ArrayList<hero>();
hero selected;
float elapsedTime;
float offsetX, offsetY;
float camspeed = 500;
float s = 1;
float timeScale = 1;
void setup() {
  size(600, 600, P2D);
  //fullScreen(P2D);
  hero aronn = new hero("aronn",70,180,30);
  aronn.x = random(0,width);
  aronn.y = random(0,height);
  aronn.maxspeed = 512;
  aronn.attackRange = 100;
  hero bigvitek = new hero("bigvitek", 200, 70, 50);
  bigvitek.x = random(0,width);
  bigvitek.y = random(0,height);
  hero pony = new hero("Pony", 10000, 15, 0);
  pony.maxspeed = 150;
  heroes.add(aronn);
  heroes.add(bigvitek);
  heroes.add(pony);
  frameRate(120);
  rectMode(CORNERS);
  smooth(16);
  strokeCap(SQUARE);
  strokeWeight(2);
  stroke(0);
}
void draw() {
  elapsedTime = 1/frameRate * timeScale;
  background(30);
  pushMatrix();
  translate(offsetX, offsetY);
  //stroke(0);
  for (hero h : heroes) {
    h.update();
    h.show();
  }
  popMatrix();

  for (int i = heroes.size() - 1; i >= 0; i--) {
    hero part = heroes.get(i);
    if (part.dead) {
      heroes.remove(i);
    }
  }

  if (mouseX+30>width)
    offsetX-=camspeed * elapsedTime;
  if (mouseX-30<0)
    offsetX+=camspeed * elapsedTime;
  if (mouseY+30>height)
    offsetY-=camspeed * elapsedTime;
  if (mouseY-30<0)
    offsetY+=camspeed * elapsedTime;
  text(frameRate, 10, 15);
}
