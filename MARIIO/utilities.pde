int GetTile(int x, int y) {
  if (x>=0 && x<level.Width && y>=0 && y<level.Height)
    return y * level.Width + x;
  else
    return 0;
}

void SetTile(int x, int y, char c) {
  if (x>=0 && x<level.Width && y>=0 && y<level.Height)
    replaceCharAt(level.levelString, y*level.Width+x, c);
}

String replaceCharAt(String s, int pos, char c) {
  char[] ch = new char[s.length()];
  s.getChars(0, ch.length, ch, 0);
  ch[pos] = c;
  return new String(ch);
}

void mousePressed() {
  //if(mouseButton == LEFT){
  //print(mouseX/tileWidth+offsetX+" ");
  //  Tile til = tiles.get(GetTile(floor(mouseX/tileWidth+offsetX), floor(mouseY/tileHeight+offsetY)));
  //  if(til.ch == '#')
  //   til.ch = '.';
  //  else til.ch = '#';
  //}
}


void keyPressed() {
  //if(key == 'w' || key == 'W'){
  //  player.up = true;
  //} 
  if (key == 's' || key == 'S') {
    player.down = true;
  } 
  if (key == 'a' || key == 'A') {
    player.left = true;
  } 
  if (key == 'd' || key == 'D') {
    player.right = true;
  } 
  //ТУПОЙ ДАУН ЗДЕСЬ ИСПРАВЬ ТУТ ПРЫЖОК СПАМИТСЯ 
  if (key == ' '|| key == 'w') {
    if (player.onGround && player.canJump) {
      player.vel.y = -13.5;
      player.canJump = false;
    }
  }
}
void keyReleased() {
  //if(key == 'w' || key == 'W'){
  // player.up = false;
  //} 
  if (key == 's' || key == 'S') {
    player.down = false;
  } 
  if (key == 'a' || key == 'A') {
    player.left = false;
  } 
  if (key == 'd' || key == 'D') {
    player.right = false;
  }
}
