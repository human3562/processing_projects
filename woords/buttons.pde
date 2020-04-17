//ArrayList<button> buttons = new ArrayList<button>();
class settingsA {
  ArrayList<setting> settings = new ArrayList<setting>();
  int selected = 0;
  void show() {
    if (!settings.isEmpty()) {
      for (setting s : settings) s.selected = false; 
      settings.get(selected).selected = true;
      for (setting s : settings) s.show();
    }
  }
  void update() {
    if (!settings.isEmpty()) {
      if ((keyCode == 'w' || keyCode == 'W' || keyCode == UP) && selected>0) selected--;
      else if ((keyCode == 's' || keyCode == 'S' || keyCode == DOWN) && selected<settings.size()-1) selected++;
      else settings.get(selected).update();
    }
  }
  void mouseUpdate() {
    if (!settings.isEmpty()) {
      for (setting s : settings) if (s.mOver) s.update();
    }
  }
}

class setting {
  boolean active = true;
  boolean act = false;
  int value = 0;
  boolean selected = false;
  String name = "";
  boolean mOver = false;
  void show() {
  }//this function should include mouseOver
  void update() {
  }//call this in keyPressed
}

class bool extends setting {
  float x, y;
  bool(String _name, float _x, float _y, boolean defaultVal) {
    name = _name;
    x = _x;
    y = _y;
    act = defaultVal;
  }
  void show() {
    mOver = (mouseX > x && mouseX < x+40 && mouseY > y-10 && mouseY < y+10);
    fill(255);
    stroke(180);
    strokeWeight(8);
    line(x, y, x+40, y);
    strokeWeight(1);
    stroke((selected?color(255, 0, 0):color(180)));
    ellipse((act == false)?x:x+40, y, 20, 20);
    textAlign(LEFT, CENTER);
    textSize(20);
    text(name+(act?": ВКЛ":": ВЫКЛ"), x+60, y-4);
  }
  void update() {
    if (mouseX > x && mouseX < x+40 && mouseY > y-10 && mouseY < y+10) act = !act;
    if (keyCode == ENTER || keyCode == RETURN) act = !act;
    if (keyCode == 'a' || keyCode == 'A' || keyCode == LEFT) act = false;
    if (keyCode == 'd' || keyCode == 'D' || keyCode == RIGHT) act = true;
  }
}
class slider extends setting {
  float x, y;
  int min, max;
  slider(String _name, float _x, float _y, int minAmt, int maxAmt, int defAmt) {
    name = _name;
    x = _x;
    y = _y;
    min = minAmt;
    max = maxAmt;
    value = defAmt;
  }
  void show() {
    fill(255);
    stroke(180);
    strokeWeight(8);
    line(x, y, x+200, y);
    strokeWeight(1);
    stroke((selected?color(255, 0, 0):color(180)));
    ellipse(map(value, min, max, x, x+200), y, 20, 20);
    textAlign(LEFT, CENTER);
    textSize(20);
    text(name+": "+value, x+220, y-4);
  }
  void update() {
    if (keyCode == 'a' || keyCode == 'A' || keyCode == LEFT) {
      if (value>min) value--;
    }
    if (keyCode == 'd' || keyCode == 'D' || keyCode == RIGHT) {
      if (value<max) value++;
    }
  }
}
class button extends setting {
  float x, y, w, h;
  //boolean activated = false;
  button(String _name, float _x, float _y, float _w, float _h) {
    name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  void show() {
    rectMode(CENTER);
    fill(180);
    stroke(0);
    if ((mouseX>x-w/2 && mouseX<x+w/2 && mouseY>y-h/2 && mouseY<y+h/2) || selected) {
      stroke(255, 0, 0);
      strokeWeight(1);
      mOver = true;
    } else {
      noStroke();
      mOver = false;
    }
    rect(x, y, w, h);
    fill(0);
    if (act) fill(255, 0, 0);
    act = false;
    textAlign(CENTER, CENTER);
    text(name, x, y);
  }
  void update() {
    if (mouseX>x-w/2 && mouseX<x+w/2 && mouseY>y-h/2 && mouseY<y+h/2) {
      act = true;
    }
    if (keyCode == ENTER || keyCode == RETURN) act = true;
  }
}
