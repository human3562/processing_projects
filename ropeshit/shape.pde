class Shape {
  ropeVert[] verts = new ropeVert[4];
  color c;
  float x,y;
  float w,h;
  Shape(float _x, float _y, float _w, float _h) {
    x = _x; y = _y; w = _w; h = _h;
    verts[0] = new ropeVert(x, y, 0);
    verts[1] = new ropeVert(x+w, y, 1);
    verts[2] = new ropeVert(x+w, y+h, 2);
    verts[3] = new ropeVert(x, y+h, 3);

    int r = floor(random(0, 255));
    int g = floor(random(0, 255));
    int b = floor(random(0, 255));
    c = color(r, g, b);
  }
  void show() {
    noStroke();
    fill(c); 
    beginShape();
    for (int i = 0; i<4; i++) {
      vertex(verts[i].x, verts[i].y);
    }
    endShape();
  }
}
