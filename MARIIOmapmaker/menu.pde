class Menu {
  float x1, y1, x2, y2;
  boolean mouseOver = false;
  float posX = width - 246;
  float P; //goes from 0 to 1
  Menu() {
    x1 = width;
    y1 = 0;
    x2 = width+10;
    y2 = height;
  }

  void update() {
    if (mouseX >= x1 && mouseX < x2 && mouseY >= y1 && mouseY < y2) 
      mouseOver = true;
    else mouseOver = false;
    if (menuUp) {
      if (P>0)
        P-=0.1;
    } else {
      if (P<1)
        P+=0.1;
    }
    x1 = posX + (width-posX)*P;
    fill(0);
    noStroke();
    rect(x1, y1, x2, y2);
  }
}
