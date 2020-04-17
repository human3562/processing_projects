float offsetX, offsetY;
int gridSizeX = 10;
int gridSizeY = 10;
float rW = 64;
float zoom = 1;
float elapsedTime = 0;
float globalTimer = 0;
void setup() {
  size(1000, 700);
  //fullScreen();
  for (int i = 0; i<gridSizeX; i++) {
    for (int j = 0; j<gridSizeY; j++) {
      storageGrid.add(new sCell(j, i));
    }
  }
  storageGrid.get(5).putObj(new dummy(), 5);
  storageGrid.get(13).putObj(new apple(), 5);
  storageGrid.get(30).putObj(new rice(), 5);
  bots.add(new sBot(0,0,bots.size()));
  bots.add(new sBot(1, 1,bots.size()));
  bots.add(new sBot(2, 2,bots.size()));
  bots.get(0).commands.add(new moveTo(9,9));
  bots.get(0).commands.add(new moveTo(0,0));
  bots.get(0).getProduct("dummy",4);
  bots.get(0).commands.add(new moveTo(5,5));
}

void draw() {
  elapsedTime = 1/frameRate;
  globalTimer += elapsedTime;
  background(200);
  pushMatrix();
  scale(zoom);
  translate(-offsetX, -offsetY);
  noFill();
  rectMode(CORNER);
  rect(0, 0, width * 1/scl, height * 1/scl);
  ellipse(width/2 * 1/scl, height/2 * 1/scl, 30 * 1/scl, 30 * 1/scl);

  for (sCell c : storageGrid) {
    noFill();
    stroke(0);
    strokeWeight(1);
    if (c.storageObj!=null) {
      fill(c.storageObj.c);
    }
    rect(c.idX * rW * 1/scl, c.idY * rW * 1/scl, rW * 1/scl, rW * 1/scl);
    if (c.storageObj!=null) {
      fill(0);
      textAlign(CENTER);
      text(c.storageObj.name+"\n"+c.amt, (c.idX * rW + rW/2) * 1/scl, (c.idY * rW + rW/2) * 1/scl);
    }
  }
  
  if (!bots.isEmpty())
    for (sBot b : bots) {
      b.update();
      b.show();
    }
  textSize(12);
  popMatrix();
  rectMode(CORNER);
  fill(0);
  textAlign(LEFT, CENTER);
  text("FPS: "+frameRate, 10, 10);
  text("Zoom amt: "+zoom, 10, 25);
  if (cmdType) {
    stroke(0);
    rect(0, height-15, width, 15);
    fill(255);
    text(command, 0, height-15);
  }
  mousePos();
}
