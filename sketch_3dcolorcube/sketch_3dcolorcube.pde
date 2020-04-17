float scl = 1;
void setup() {
  size(600, 600, P3D);
  strokeWeight(5);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateY(map(mouseX, 0, width, 0, TWO_PI));
  rotateX(map(mouseY, 0, height, 0, TWO_PI));
  stroke(255);
  line(0, 0, 0, 255*scl, 0, 0);
  line(0, 0, 0, 0, 255*scl, 0);
  line(0, 0, 0, 0, 0, -255*scl);
  for (int x = 0; x<255/16; x++) {
    for (int y = 0; y<255/16; y++) {
      for (int z = 0; z<255/16; z++) {
        pushMatrix();
        translate(x*scl*16, y*scl*16, -z*scl*16);
        stroke(x*16,y*16,z*16);
        point(0,0,0);
        popMatrix();
      }
    }
  }
  popMatrix();
  text(frameRate,width-100,10);
}


void mouseWheel(MouseEvent event) {
  scl -= event.getCount() * 0.1;
  if (scl>6) scl = 6;
  if (scl<0.3) scl = 0.3;
}
