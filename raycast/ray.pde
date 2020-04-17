class ray {
  PVector pos;
  PVector dir;
  float a;

  ray(float x, float y, float a) {
    pos = new PVector(x, y);
    dir = new PVector(cos(a), sin(a));
    this.a = a;
  }

  void show() {
    //stroke(255);
    //strokeWeight(1);
    //line(pos.x, pos.y, pos.x+dir.x*10, pos.y + dir.y*10);
  }

  void lookAt(float x, float y) {
    dir.x = x - pos.x;
    dir.y = y - pos.y;
    dir.normalize();
  }

  PVector cast(wall w) {
    float x1 = w.x1;
    float y1 = w.y1;
    float x2 = w.x2;
    float y2 = w.y2;

    float x3 = pos.x;
    float y3 = pos.y;
    float x4 = pos.x + dir.x;
    float y4 = pos.y + dir.y;

    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) return null;

    float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4)) / den;
    float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3)) / den;

    if (t > 0 && t < 1 && u > 0) {
      return new PVector(x1+t*(x2-x1), y1+t*(y2-y1));
    } else {
      return null;
    }
  }
}
