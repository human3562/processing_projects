float sltimer = 0;
int GetTile(int x, int y) {
  if (x<0 || x>levels.get(currentLevel).levelWidth*64 || y<0 || y>levels.get(0).levelHeight*64) {
    return levels.get(currentLevel).blockcount;
  } else {
    int idX = floor(map(x, 0, levels.get(currentLevel).levelWidth*64, 0, levels.get(currentLevel).levelWidth));
    int idY = floor(map(y, 0, levels.get(currentLevel).levelHeight*64, 0, levels.get(currentLevel).levelHeight));
    int fin = idX + idY * levels.get(currentLevel).levelWidth;
    if (fin>=levels.get(currentLevel).blockcount) {
      return levels.get(currentLevel).blockcount;
    } else
      return(fin);
  }
}

boolean collidesWithPlayer(float x, float y) {
  if (x>Player.xPosition-32 && x<Player.xPosition+32 && y>Player.yPosition-32 && y<Player.yPosition+32)
    return true;
  else return false;
}


float slowdur = 0;
float slowp = 0;

void slowdown(float sd, float sp) {
  sltimer = 0;
  slowdur = sp;
  slowp = sd;
}

void slow() {
  if (sltimer<slowdur) {
    timestep = slowp;
  } else {
    if (timestep<targettimescale) {
      timestep+=0.05;
      if (timestep>targettimescale) timestep = targettimescale;
    }
    if (timestep>targettimescale) {
      timestep-=0.005;
      if (timestep<0) timestep = 0;
    }
    //println("ass");
  }
  sltimer += 1/frameRate;
}
float targetFade = 0;
void fade() {
  if (fade<targetFade) {
    fade+=10;
    if (fade>targetFade) fade = targetFade;
  }
  if (fade>targetFade) {
    fade-=10;
    if (fade<0) fade = 0;
  }
}

boolean onScreen(float x, float y, float r) {
  if (x+r>-offsetX && x-r<-offsetX+width && y+r>-offsetY && y-r<-offsetY+height)
    return true;
  else return false;
}

void mousePressed() {
  //sp.setToLoopStart();
  //sp.start();
  if (mouseButton == LEFT&&Player.canMove) {
    mposX = mouseX;
    mposY = mouseY;
    //  grenades.add(new grenade(Player.xPosition, Player.yPosition, ((mouseX-offsetX) - Player.xPosition)*2, ((mouseY-offsetY) - Player.yPosition)*2, 100, 1));
  }
  if (mouseButton == RIGHT) {
    turrets.add(new turret(mouseX-offsetX, mouseY-offsetY, 5000, 0.1, 5));
  }
}

void mouseDragged() {
  if (mouseButton == LEFT && Player.canMove) {
    throwX += pmouseX-mouseX;
    throwY += pmouseY-mouseY;
    ta = atan2(throwY, throwX);
    td = dist(mouseX, mouseY, mposX, mposY)*4;
    if (td>1000) td = 1000;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT && Player.canMove && throwX!=0 || throwY!=0) {
    grenades.add(new grenade(Player.xPosition, Player.yPosition, cos(ta) * -td + Player.xspeed, sin(ta) * -td + Player.yspeed, 50, 5));
    td = 0;
    throwX = 0;
    throwY = 0;
  }
  throwX = 0;
  throwY = 0;
  td = 0;
} 

void keyPressed() {
  if (talkto!=-1) {
    if (keyCode == 's' || keyCode == 'S') {
      if (characters.get(talkto).questions.get(characters.get(talkto).currentQ).answers!=null) {
        if (selectedA<characters.get(talkto).questions.get(characters.get(talkto).currentQ).answers.size()-1) {
          selectedA++;
        }
      }
    }
    if (keyCode == 'w' || keyCode == 'W') {
      if (selectedA>0) {
        selectedA--;
      }
    }
    if (key == ENTER) {
      if (characters.get(talkto).questions.get(characters.get(talkto).currentQ).answers!=null) {
        characters.get(talkto).say();
      }else{
        characters.get(talkto).say(); 
      }
    }
  } else {
    
    if (keyCode == 'w' || keyCode == 'W') {
      Player.up = true;
    }
    if (keyCode == 'g' || keyCode == 'G') {
      Player.takeDamage(1);
    }
    if (keyCode == 's' || keyCode == 'S') {
      Player.down = true;
    }
    if (keyCode == 'd' || keyCode == 'D') {
      Player.right = true;
      Player.flipTexture = false;
    }
    if (keyCode == 'a' || keyCode == 'A') {
      Player.left = true;
      Player.flipTexture = true;
    }
    if (keyCode == 'r' || keyCode == 'R') {
      Player.heal(100);
      //godCutscene();
    }
    if (keyCode == 'i' || keyCode == 'I') {
      Player.inventory.show = !Player.inventory.show;
      targetFade = (Player.inventory.show ? 170 : 0);
    }
    if(keyCode == 'c' || keyCode == 'C'){
      Player.jetpack = !Player.jetpack; 
    }
    if (keyCode == 'e' || keyCode == 'E') {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(Player.xPosition), floor(Player.yPosition))).isPointer) {
        println("starting level-change");
        for (levelPointer p : levels.get(currentLevel).pointers) {
          if (p.blockId == GetTile(floor(Player.xPosition), floor(Player.yPosition))) {
            println("currentLevel set to:");
            levels.get(currentLevel).isStarted = false;
            currentLevel = p.levelId-1;
            Player.xPosition = 64*2;
            Player.yPosition = 64*2;
            Player.xspeed = 0;
            Player.yspeed = 0;
            setLevels();
            print(currentLevel);
          }
        }
      }else{
        if(!characters.isEmpty()){
          //println("ayy");
          for(character c : characters){
            if(collidesWithPlayer(c.xPosition,c.yPosition)){
              //println("ass");
              talkto = c.id;
              Player.canMove = false;
              targetFade = 170;
              c.showArt = true;
            }
          }
        }
      }
    }
    if (keyCode == ' ') {
      if (Player.onGround&&Player.canMove) {
        Player.yspeed -= Player.jumpspeed;
        Player.jumped = true;
      }
    }
  }
}



void keyReleased() {
  if (keyCode == 'w' || keyCode == 'W') {
    Player.up = false;
  }
  if (keyCode == 's' || keyCode == 'S') {
    Player.down = false;
  }
  if (keyCode == 'd' || keyCode == 'D') {
    Player.right = false;
  }
  if (keyCode == 'a' || keyCode == 'A') {
    Player.left = false;
  }
}

void mouseWheel(MouseEvent event) {
  scl -= event.getCount() * 0.05;
  if (scl>4) scl = 4;
  if (scl<1) scl = 1;
}
