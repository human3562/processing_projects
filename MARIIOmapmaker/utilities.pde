int GetTile(int x, int y) {
  if (x>=0 && x<levelWidth && y>=0 && y<levelHeight)
    return y * levelWidth + x;
  else
    return -1;
}

void mousePressed() {
  if (mouseButton == LEFT) {

    b.clickDown();
    if (focusedTile == -1) {
      selectedTexture = 0;
    }
    for (Button b : textureButtons) {
      if (focusedTile == -1)
        b.isPressed = false;
      b.clickDown();
    }
    if (focusedTile!=-1 && focusedTile!=-2) {
      Tile t = tiles.get(focusedTile);
      if (t.textureId == 0) {
        t.textureId = selectedTexture;
        t.isSolid = true;
      } else {
        t.textureId = 0;
        t.isSolid = false;
      }
    }
  }
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    b.clickUp();
    for (Button b : textureButtons)
      b.clickUp();
  }
}

void keyPressed() {
  if (key == 'e' || key == 'E') {
    if (b.isPressed)
      b.isPressed = false;
    else b.isPressed = true;
  }
  if (key == 'w' || key == 'W') {
    up = true;
  }
  if (key == 'd' || key == 'D') {
    right = true;
  }
  if (key == 's' || key == 'S') {
    down = true;
  }
  if (key == 'a' || key == 'A') {
    left = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    up = false;
  }
  if (key == 'd' || key == 'D') {
    right = false;
  }
  if (key == 's' || key == 'S') {
    down = false;
  }
  if (key == 'a' || key == 'A') {
    left = false;
  }
}

void cInput() {
  if (up == true)
    cameraPosY-=1;
  if (right == true)
    cameraPosX+=1;
  if (down == true)
    cameraPosY+=1;
  if (left == true)
    cameraPosX-=1;
  if (cameraPosX<0)
    cameraPosX = 0;
  if (cameraPosY<0)
    cameraPosY = 0;
  if (cameraPosX>levelWidth)
    cameraPosX = levelWidth;
  if (cameraPosY>levelHeight)
    cameraPosY = levelHeight;
}
