void mouseWheel(MouseEvent e){
  timeScale += e.getCount() * 0.1;
  if(timeScale<0) timeScale = 0;
  if(timeScale>1) timeScale = 1;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (hero h : heroes) {
      if (dist(mouseX-offsetX, mouseY-offsetY, h.x, h.y)<20) {
        selected = h;
      }
    }
  }

  if (mouseButton == RIGHT) {
    if (selected != null) {
      boolean isAttack = false;
      for (hero h : heroes) {
        if (dist(mouseX-offsetX, mouseY-offsetY, h.x, h.y)<10 && selected != h) {
          isAttack = true;
          selected.events.add(new attack(selected, h));
        }
      }
      if (!isAttack) {
        selected.events.clear();
        selected.events.add(new moveTo(selected, mouseX-offsetX, mouseY-offsetY));
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    hero dummy = new hero("testDummy",100,0,5);
    dummy.x = mouseX-offsetX;
    dummy.y = mouseY-offsetY;
    heroes.add(dummy);
  }
} 

boolean mouseInBox(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    return true;
  } else return false;
} 
