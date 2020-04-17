void mousePressed() {
}

void mouseReleased() {
  if (GameState == 1) {
    if (!events.isEmpty()) {
      for (Button b : events.get(0).buttons) {
        if (mouseInBox(b.x, b.y, b.w, b.h)) {
          if (b.isActive) {
            b.isPressed = true;
            break;
          }
        }
      }
    }
  }
  if (GameState == 0) {
    for (Button b : menuEvents.get(0).buttons) {
      if (mouseInBox(b.x, b.y, b.w, b.h)) {
        if (b.isActive) {
          b.isPressed = true;
          break;
        }
      }
    }
  }
}


void mouseWheel(MouseEvent event) {
  //line(0,ay,width,ay);
  //if(ay > height){
  Ystring-=event.getCount()*5;

  //}
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    popups.add(new popup("this is a dummy popup meant for debugging purposes. If you see this in the end game then you are full of shit btw", 2, 0));
  }

  if (trygetname) {
    if (key == BACKSPACE) {
      if (!playerName.isEmpty())
        playerName = playerName.substring(0, playerName.length()-1);
    } else if (key!=' '&& key!=CODED && key!=TAB && key!=ENTER) {
      playerName += key;
    }
  }
}

boolean mouseInBox(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    return true;
  } else return false;
} 


class wait extends event {
  float sec = 0;
  float time = 0;
  boolean anim = false;
  float a = 0;
  wait(float seconds, boolean animate) {
    sec = seconds;
    anim = animate;
  }

  void Start() {
  }

  void Update() {

    if (anim) {
      pushMatrix();
      translate(width/2, height/2);
      rotate(a);
      image(load, 0, 0, 60, 60);
      popMatrix();
      pushMatrix();
      //rect(width/2,height/2-5,100,16);
      textSize(20);
      textAlign(CENTER);
      fill(0);
      text("PLEASE WAIT", width/2, height-100);
      popMatrix();
    }

    if (time>=sec) 
      completed = true;
    else
      time += 1/frameRate;
    if (frameCount%2 == 1)
      a-=PI/6;
  }
}
