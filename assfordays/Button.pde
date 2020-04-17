class Button {
  float x, y, w, h;
  String text = "";
  boolean isPressed = false;
  boolean mouseOver = false;
  boolean isActive = true;
  int id = 0;

  Button(int _id, String name) {
    text = name;
    id = _id;
  }

  void update() {
    mouseOver = mouseInBox(x, y, w, h);
    int c;
    if (isActive)
      c = (mouseOver)? 200 : 100;
    else c = 50;
    pushMatrix();
    stroke(255);
    fill(c);
    rect(x, y, w, h);
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    text(text, x + 5, y+5, w-5, h*2);
    popMatrix();
  }
}
