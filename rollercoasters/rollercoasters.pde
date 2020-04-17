float elapsedTime = 0;
ArrayList<trackLine> track = new ArrayList<trackLine>();
String state = "SETUP";
cart player;
circleSelect gSelect;
float G = 350;
void setup() {
  size(600, 600);
  //fullScreen();
  g = new PVector(0,G);
  gSelect = new circleSelect(0,0);
  frameRate(60);
  //track.add(new trackLine(0,0,width/2-200,height/2));
  //track.add(new trackLine(width/2-200,height/2,width/2-100,height/2+100));
  //track.add(new trackLine(width/2-100,height/2+100,width/2,height/2+100));
  //track.add(new trackLine(width/2,height/2+100,width/2+50,height/2));
  //track.add(new trackLine(width/2+50,height/2,width/2-10,height/2-100));
  //track.add(new trackLine(width/2-10,height/2-100,width/2-100,height/2-50));
  //track.add(new trackLine(width/2-100,height/2-50,width/2-150,height/2+100));
  //track.add(new trackLine(width/2-150,height/2+100,width/2+100,height/2+200));
  //track.add(new trackLine(width/2+100,height/2+200,width/2+200,height/2+100));
  //setTrackPortals();
  //player = new cart(track.get(0));
}

void draw() {
  elapsedTime = 1/frameRate;
  switch(state) {
  case "SETUP": 
    stUp(); 
    break;
  case "GAME": 
    game(); 
    break;
  }
}
PVector pMPos;
void stUp() {
  background(100);
  updateSetting();
  if (frameCount % 3 == 0) {
    if (mDown && !sDown) {
      if (pMPos == null) pMPos = new PVector(mouseX, mouseY);
      if (PVector.dist(pMPos, new PVector(mouseX, mouseY)) > 0.5) {
        if (track.isEmpty()) {
          if (pMPos!=null) track.add(new trackLine(pMPos.x, pMPos.y, mouseX, mouseY));
        } else {
          PVector p = track.get(track.size()-1).end;
          if (pMPos!=null) track.add(new trackLine(p.x, p.y, mouseX, mouseY));
        }
      }
    }
  }
  if (!track.isEmpty())
    for (trackLine t : track) {
      t.show();
    }
  pMPos = new PVector(mouseX, mouseY);
}

void game() {
  background(100);
  updateSetting();
  for (trackLine t : track) {
    t.show();
  }
  player.update();
  player.show();
  fill(255);
  textSize(12);
  text("FPS: "+frameRate, 10, 10);
  text("track pieces: "+ track.size(), 10, 25);
}
