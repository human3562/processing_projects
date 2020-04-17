class trackLine {
  
  PVector start;
  PVector end;
  float len;
  trackLine prev = null;
  trackLine next = null;
  
  trackLine(float x1, float y1, float x2, float y2) { //please dont fucking put the start and the end in the same position
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
    len = PVector.dist(start, end);
  }
  
  void show(){
    stroke(255);
    line(start.x, start.y, end.x, end.y);
  }
  
}
