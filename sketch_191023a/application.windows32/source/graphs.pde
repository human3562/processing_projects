class cGraphz {
  ArrayList<gPoint> points = new ArrayList<gPoint>();
  float posX = 0;
  float posY = 0;
  float gWidth = 100;
  float gHeight = 100;
  float maxY = 0.1;
  float minY = 1000000;
  float pointLimit = 100;
  int iterations = 0;

  void show() {
    rectMode(CENTER);
    fill(50);
    noStroke();
    rect(posX, posY, gWidth, gHeight);

    stroke(255);
    fill(255);
    line(posX - gWidth/2, posY + gHeight/2, posX - gWidth/2, posY - gHeight/2);
    text(maxY, posX-gWidth/2, posY-gHeight/2);
    text(minY, posX-gWidth/2, 10+posY+gHeight/2);


    line(posX - gWidth/2, posY + gHeight/2, posX + gWidth/2, posY + gHeight/2);
    text("X", posX+gWidth/2, posY+gHeight/2);

    //gPoint prevP = null;
    float px=0; 
    float py = 0;
    if (!points.isEmpty()) {

      if (iterations > 2) {
        float step = gHeight/(maxY - minY);

        //  float nUp = floor((maxY*step)/10);

        //  stroke(255);
        //  for (int i = 0; i < nUp; i++) {
        //    float yt =  (posY) - maxY*step*i;
        //    line(posX-gWidth/2, yt, posX+gWidth/2, yt);
        //  }


        float zeroY = (posY-gHeight/2) + maxY*step;
        stroke(120);
        if (zeroY > 0 && zeroY < gHeight) {
          fill(255);
          line(posX-gWidth/2, zeroY, posX+gWidth/2, zeroY);
          text("0", posX - 10 - gWidth/2, zeroY);
        }
        stroke(255);
      }

      for (int i = 0; i < points.size(); i++) {
        gPoint p = points.get(i);
        float x = (gWidth/points.size()) * i;

        if (p.y > maxY) maxY = p.y;

        //if (minSet == false){ minY = p.y; minSet = true;}
        if (p.y < minY) minY = p.y;
        if (points.size()>2) {
          float y = map(p.y, minY, maxY, 0, gHeight);


          if (i-1 > 0) {
            line((posX-gWidth/2)+x, (posY+gHeight/2)-y, (posX-gWidth/2)+px, (posY+gHeight/2)-py);
          }
          ellipse((posX - gWidth/2) + x, (posY + gHeight/2) - y, 1, 1);
          px = x;
          py = y;
        }
      }
    }
    if (pointLimit > 0 && points.size() > pointLimit) {

      for (int i = points.size()-1; i > pointLimit; i--) {
        points.remove(0);
      }
    }
    //println(maxT);
    iterations++;
  }
}

class recGraph extends cGraphz {
  recGraph(float x, float y, float w, float h) {
    posX = x;
    posY = y;
    gWidth = w;
    gHeight = h;
  }
  void addP(float t, float x) {
    points.add(new gPoint(t, x));
  }
}

class gPoint {
  float x; 
  float y;
  gPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
