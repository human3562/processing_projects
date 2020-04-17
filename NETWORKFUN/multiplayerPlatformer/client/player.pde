class player {
  String id;
  float x, y;
  void show() {
    fill(255);
    noStroke();
    rectMode(CENTER);
    rect(x, y, 64, 64);
  }
} 
