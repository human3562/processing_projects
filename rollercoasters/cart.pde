PVector g;
class cart {
  PVector pos;
  trackLine currentSegment;
  float speed;
  float acc;
  float d = 0;
  float input;
  float m = 1;

  cart(trackLine start) {
    currentSegment = start;
    pos = new PVector(0, 0);
  }

  void update() {
    if (left) input = -1;
    else if (right) input = 1;
    else input = 0;
    physics();
    speed += input;
    speed += m * acc * elapsedTime;
    speed = speed*0.999;
    if(abs(speed)<0.01) speed = 0;
    d += speed * elapsedTime;

    recCheck();

    pos = PVector.lerp(currentSegment.start, currentSegment.end, d/currentSegment.len);
  }

  void recCheck() {
    while (true) {
      if (d<0) {
        if (currentSegment.prev != null) {
          float dif = d;
          currentSegment = currentSegment.prev;
          d = currentSegment.len+dif;
        } else {
          d = 0; 
          speed*=-0.3;
        }
      } else break;
    }
    while (true) {
      if (d>currentSegment.len) {
        if (currentSegment.next != null) {
          float dif = d-currentSegment.len;
          currentSegment = currentSegment.next; 
          d = dif;
        } else { 
          d = currentSegment.len; 
          speed*=-0.3;
        }
      } else break;
    }
  }

  void physics() {
    float a = atan2(currentSegment.start.y-currentSegment.end.y, currentSegment.start.x - currentSegment.end.x);
    if (a>0) {
      stroke(255, 0, 0);
      PVector c = new PVector(cos(a), sin(a));
      acc = -PVector.dot(c, g);
    } else {
      stroke(0, 255, 0);
      PVector c = new PVector(-cos(a), -sin(a));
      acc = PVector.dot(c, g);
    }
    println(acc);
    strokeWeight(1);
    line(pos.x-100, pos.y, pos.x+100, pos.y);
    line(pos.x, pos.y, pos.x+g.x, pos.y+g.y);
    line(pos.x + cos(a)*150, pos.y + sin(a)*150, pos.x - cos(a)*150, pos.y - sin(a)*150);
  }

  void show() {
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, 10, 10);
    textSize(12);
    text(abs(speed), pos.x, pos.y-10);
  }
}

void setTrackPortals() {
  trackLine t = new trackLine(track.get(track.size()-1).end.x, track.get(track.size()-1).end.y, track.get(0).start.x, track.get(0).start.y);
  t.next = track.get(0);
  track.add(t);
  track.get(0).prev = track.get(track.size()-1);
  for (int i = 0; i<track.size(); i++) {
    int prev = i-1;
    int next = i+1;
    trackLine p = null;
    trackLine n = null;
    if (prev >= 0) p = track.get(prev);
    if (next < track.size()) n = track.get(next);
    if (p!=null) track.get(i).prev = p;
    if (n!=null) track.get(i).next = n;
  }
}
