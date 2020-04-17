float G = 9.81;
class player {
  float positionX = 300;
  float positionY = 0;
  float speedX = 0;
  float speedY = 0;
  float maxSpeed = 200;
  float moveSpeed = 50;
  float w = 64;
  float h = 64;
  String IP;

  boolean up, down, left, right;

  player(String ip) {
    IP = ip;
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    noStroke();
    rect(positionX, positionY, w, h);
  }

  void update() {
    if (left) speedX -= moveSpeed;
    if (right) speedX += moveSpeed;
    speedX *= 0.9;
    if (abs(speedX)<0.1) speedX = 0;
    speedY += G;
    positionX += speedX * elapsedTime;
    positionY += speedY * elapsedTime;
    if (positionY+h/2 > height) positionY = height-h/2;
    if (positionX-w/2 > width) positionX = -w/2;
    if (positionX+w/2 < 0) positionX = width+w/2;
    checkCol();
  }

  void checkCol() {
    for (player p : players) {
      if (p!=this) {
        if (speedX>0) {
          if (rectCol(positionX, positionY, p.positionX-0.5, p.positionY, 64, 64, 64, 64)) {
            speedX = 0;
            positionX = p.positionX-w;
          }
        }
        if (speedX<0) {
          if (rectCol(positionX, positionY, p.positionX, p.positionY, 64, 64, 64, 64)) {
            speedX = 0;
            positionX = p.positionX+w;
          }
        }
        if(speedY>0){
           if (rectCol(positionX, positionY, p.positionX, p.positionY-0.5, 64, 64, 64, 64)) {
            speedY = 0;
            positionY = p.positionY-w-0.5;
          }
        }
      }
    }
  }
}

boolean rectCol(float x1, float y1, float x2, float y2, float sx1, float sx2, float sy1, float sy2) {
  return(x1+sx1/2>x2-sx2/2 && x1-sx1/2<x2+sx2/2 && y1+sy1/2>y2-sy2/2 && y1-sy1/2<y2+sy2/2);
}
