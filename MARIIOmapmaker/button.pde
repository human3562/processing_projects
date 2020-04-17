class Button {
  float x1, y1, x2, y2;
  boolean isSwitch;
  boolean isPressed = false;
  String text;
  PImage texture;
  boolean mouseOver = false;
  color c;
  int id;

  Button(String txt, PImage Btexture, float X1, float Y1, float X2, float Y2, int idt, boolean Switch) {
    text = txt;
    texture = Btexture;
    x1 = X1;
    y1 = Y1;
    x2 = X2;
    y2 = Y2;
    id = idt;
    isSwitch = Switch;
    c = color(255, 255, 255);
  }

  void update() {
    if (mouseX >= x1 && mouseX < x2 && mouseY >= y1 && mouseY < y2) {
      mouseOver = true;
    } else mouseOver = false;
  }

  void clickDown() {
    if (mouseX >= x1 && mouseX < x2 && mouseY >= y1 && mouseY < y2) {
      if (isSwitch) {
        if (isPressed)
          isPressed = false;
        else isPressed = true;
      } 
    }
  }

  void clickUp() {
    if (mouseX >= x1 && mouseX < x2 && mouseY >= y1 && mouseY < y2) {
      if (!isSwitch) {
        isPressed = false;
      }
    }
  }

  void show() {
    if (mouseOver) {
      stroke(0);
      if (id == -1)
        focusedTile = -2;
      else focusedTile = -1;
    } else noStroke();

    if (texture == null) {
      fill(c);
      rect(x1, y1, x2, y2);
    } else image(texture, x1, y1, x2, y2);

    if (text != null) {
      textAlign(CENTER);
      fill(0);
      text(text, x1+((x2-x1)/2), y1 + ((y2-y1)/2));
    }

    if (isPressed) {
      noFill();
      stroke(255, 0, 0);
      rect(x1, y1, x2, y2);
    }
  }
}
