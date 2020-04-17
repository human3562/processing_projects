float cWidth = 40;
class cell {
  float x, y; 
  int id;
  boolean ship = false;
  boolean enemySide = false;

  cell(float x, float y, int id) {
    this.x = x;
    this.y = y;
    this.id = id;
  }

  cell(float x, float y, int id, boolean enemy) {
    this.x = x;
    this.y = y;
    this.id = id;
    enemySide = enemy;
  }

  void show() {
    stroke(0);
    if (enemySide)
      fill(mOver()?color(255, 0, 0):255);
    else
      fill(mOver()?color(0, 255, 0):255);
    rectMode(CENTER);
    rect(x, y, cWidth, cWidth);
    //fill(0);
    //text(id,x,y);
  }

  boolean mOver() {
    return(mouseX>x-cWidth/2 && mouseX<x+cWidth/2 && mouseY>y-cWidth/2 && mouseY<y+cWidth/2);
  }
}
