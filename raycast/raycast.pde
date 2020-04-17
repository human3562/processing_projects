int res = 1;
float elapsedTime = 0;
ArrayList<wall> alWalls = new ArrayList<wall>();
wall w;
player p;
void setup() {
  size(1200, 600, P2D);
  //fullScreen(P2D);
  w = new wall(500, 100, 500, 500);
  alWalls.add(w);
  alWalls.add(new wall(0,0,width,0));
  alWalls.add(new wall(width/2,0,width/2,height));
  alWalls.add(new wall(width,height,0,height));
  alWalls.add(new wall(0,height,0,0));
  p = new player(300, 300, 45);
}
void draw() {
  elapsedTime = 1/frameRate;
  background(0);
  //rectMode(CORNERS);
  //fill(0,0,255);
  //rect(0,height/2,width,height);
  p.update();
  p.show();
  for(wall w : alWalls){
    w.show(); 
  }
  text("FPS: "+frameRate,10,10);
  text("rays: "+p.rays.length,10,25);
}
