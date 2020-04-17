class player {
  ray[] rays;
  PVector pos;
  float a;
  float FOV;
  boolean up, down, left, right;
  float speed = 100;
  player(float x, float y, float FOV) {
    pos = new PVector(x, y);
    this.FOV = FOV;
    int r = (width/2)/res;
    rays = new ray[r];
    for (int i = 0; i<r; i++) {
      rays[i] = new ray(x, y, radians(map(i, 0, r, -FOV/2, FOV/2)));
    }
  }
  void update() {
    if (up) { 
      pos.x+=speed*cos(a)*elapsedTime;
      pos.y+=speed*sin(a)*elapsedTime;
    }
    if(left){
      a-=radians(speed*elapsedTime);
    }
    if(right){
      a+=radians(speed*elapsedTime); 
    }
    //a = atan2(mouseY-pos.y, mouseX-pos.x);
    for (ray r : rays) {
      r.pos = pos;
      float angle = a+r.a;
      r.dir.x = cos(angle);
      r.dir.y = sin(angle);
    }
    drawCast(alWalls);
  }

  void show() {
    stroke(255);
    ellipse(pos.x, pos.y, 5, 5);
    line(pos.x, pos.y, pos.x+cos(a)*10, pos.y + sin(a)*10);
    //for (ray r : rays) {
    //r.show();
    //}
  }

  void drawCast(ArrayList<wall> walls) {
    pushMatrix();
    translate(width/2, 0);
    for (int i = 0; i<rays.length; i++) {
      ray r = rays[i];
      PVector closest = null;
      float record = Float.POSITIVE_INFINITY;
      for (wall w : walls) {
        PVector pt = r.cast(w);
        if (pt!=null) {
          float d = PVector.dist(pos, pt);
          if (d<record) {
            record = d;
            closest = pt;
          }
        }
      }
      //if (closest!=null) {
      //  stroke(255);
      //  strokeWeight(1);
      //  line(pos.x-600, pos.y, closest.x-600, closest.y);
      //}
      rectMode(CENTER);
      noStroke();
      float d = 600;
      if (closest!=null)
        d = PVector.dist(pos, closest);
      fill(closest==null ? 0 : map(d*cos(r.dir.heading()-a), 0, 600, 255, 0));
      if (d<1) d = 1;
      float y = (height/d)*200;
      rect((i*res)+res/2, height/2, res, y);
    }
    popMatrix();
  }
}
