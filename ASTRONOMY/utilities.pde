void keyPressed() {
  if (keyCode == 'A' || keyCode == 'a') {
    left = true;
  }
  if (keyCode == 'D' || keyCode == 'd') {
    right = true;
  }
  if (keyCode == 'W' || keyCode == 'w') {
    up = true;
  }
  if (keyCode == 'S' || keyCode == 's') {
    down = true;
  }
  if (keyCode == 'z' || keyCode == 'Z') {
    mwheel = !mwheel;
  }
}

void keyReleased() {
  if (keyCode == 'A' || keyCode == 'a') {
    left = false;
  }
  if (keyCode == 'D' || keyCode == 'd') {
    right = false;
  }
  if (keyCode == 'W' || keyCode == 'w') {
    up = false;
  }
  if (keyCode == 'S' || keyCode == 's') {
    down = false;
  }
}
float x, y;
float vx, vy;
void mousePressed() {
  x = (offsetX + mouseX)/zoom; 
  y = (offsetY + mouseY)/zoom;
}

void mouseDragged() {
  vx = (offsetX + mouseX)/zoom; 
  vy = (offsetY + mouseY)/zoom;
  stroke(0, 0, 255);
  line(x, y, vx, vy);
}

void mouseReleased() {
  aBody b = new aBody(x, y, 20, 600000);
  b.velocity.x = vx-x;
  b.velocity.y = vy-y;
  if (mouseButton == LEFT)
    bodies.add(b);
  x = 0; 
  y = 0; 
  vx = 0; 
  vy = 0;
}

void mouseWheel(MouseEvent e) {
  if (mwheel) {
    zoom-=(e.getCount())*0.1;
    if (zoom < 0.5) { 
      zoom = 0.5;
      return;
    }
    if (zoom > 6) { 
      zoom = 6;
      return;
    }
  }else{
    timeScale-=(e.getCount())*0.01;
    if (timeScale < 0.01) { 
      timeScale = 0.01;
      return;
    }
    if (timeScale > 1) { 
      timeScale = 1;
      return;
    }
  }
  //float oX = (offsetX+width/2)*zoom - (offsetX+width/2);
  //float oY = (offsetY+height/2)*zoom - (offsetY+height/2);
  //offsetX -= oX;
  //offsetY -= oY;
}
