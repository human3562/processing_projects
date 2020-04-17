boolean left, right;
void keyPressed() {
  if (keyCode == 'd'||keyCode == 'D') {
    right = true;
  }
  if (keyCode == 'a'||keyCode == 'A') {
    left = true;
  }
  if (keyCode == ' ') {
    if (state == "SETUP" && !track.isEmpty()) {
      setTrackPortals();
      player = new cart(track.get(0));
      state = "GAME";
    }
  }
}
void keyReleased() {
  if (keyCode == 'd'||keyCode == 'D') {
    right = false;
  }
  if (keyCode == 'a'||keyCode == 'A') {
    left = false;
  }
}
boolean mDown = false;
boolean sDown = false;
void mousePressed() {
  //if (state == "SETUP") {
  mDown = true;
  if(gSelect.mOver()) sDown = true;
  //  if (pMPos == null) pMPos = new PVector(mouseX, mouseY);
  //  if (PVector.dist(pMPos, new PVector(mouseX, mouseY)) > 1) {
  //    if (track.isEmpty()) {
  //      if (pMPos!=null) track.add(new trackLine(pMPos.x, pMPos.y, mouseX, mouseY));
  //    } else {
  //      PVector p = track.get(track.size()-1).end;
  //      if (pMPos!=null) track.add(new trackLine(p.x, p.y, mouseX, mouseY));
  //    }
  //  }
  //  pMPos = new PVector(mouseX, mouseY);
  //}
}
void mouseReleased() {
  mDown = false;
  sDown = false;
}
