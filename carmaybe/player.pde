PImage car;
PImage wheel;
class player {
  float x, y;
  float speedx, speedy;
  float w = 40;
  float a = 0;
  float acc = 0.25;
  float maxSpeed = 50;
  boolean up, down, left, right, space;
  float turnSpeed = 0.1;
  float angleSpeed;
  float interpolateA = 0;

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(a);
    translate(w-14, (w/2)-5);
    rotate(interpolateA + PI/2);
    //line(5, 0, -5, 0);
    image(wheel, 0, 0, 8, 15);
    popMatrix();

    pushMatrix();
    translate(x, y);
    rotate(a);
    translate(w-14, (-w/2)+5);
    rotate(interpolateA + PI/2);
    //line(5, 0, -5, 0);
    image(wheel, 0, 0, 8, 15);
    popMatrix();

    noFill();
    rectMode(CENTER);
    stroke(255);
    pushMatrix();
    translate(x, y);
    rotate(a);
    //rect(0, 0, w*2, w);
    rotate(-PI/2);
    //image(car,0,0,w+10,(w*2)+10);
    image(car, 0, 0);
    popMatrix();
  }

  void update() {
    float targetAngle = 0;
    if (left) targetAngle = -PI/6;
    if (right) targetAngle = PI/6;
    //println(interpolateA);

    PVector avector = new PVector(cos((a-interpolateA)), sin((a-interpolateA)));
    stroke(255);
    //line(x,y,x+avector.x*200, y+avector.y*200);
    PVector svector = new PVector(speedx, speedy);
    svector = svector.normalize();
    float head = PVector.dot(avector, svector);
    //println(head);
    float headN = map(abs(head), 0, 1, 0.3, 1);
    if (space) headN = 0.99;
    speedx *= 0.98 * abs(headN);
    speedy *= 0.98 * abs(headN);
    if (abs(speedx) < 0.01) speedx = 0;
    if (abs(speedy) < 0.01) speedy = 0;
    if (up && !space) {
      speedx+=cos(a)*acc;
      speedy+=sin(a)*acc;
    }
    if (down && !space) {
      speedx-=cos(a)*acc;
      speedy-=sin(a)*acc;
    }
    float speedMag = sqrt((speedx*speedx)+(speedy*speedy));
    if (speedMag>maxSpeed) {
      float angle = atan2(speedy, speedx); 
      speedx = cos(angle) * maxSpeed;
      speedy = sin(angle) * maxSpeed;
    }
    float turnMult = 0;
    if (speedMag>maxSpeed/2) {
      turnMult = map(speedMag, maxSpeed/2, maxSpeed, 1, 0.1);
    } else {
      turnMult = map(speedMag, 0, maxSpeed/2, 0, 2);
    }
    //if(space) turnMult = 0;
    float tSpeed = 0;
    //if (left) {
    //  if (head>0)
    //    tSpeed-=turnSpeed * turnMult;
    //  else tSpeed+=turnSpeed * turnMult;
    //}
    //if (right) {
    //  if (head>0)
    //    tSpeed+=turnSpeed * turnMult;
    //  else tSpeed-=turnSpeed * turnMult;
    //}
    if (head>0)
      tSpeed += interpolateA * 0.2 * turnMult;
    else tSpeed -= interpolateA * 0.2 * turnMult;
    angleSpeed += tSpeed;
    angleSpeed *= 0.4;
    if(abs(angleSpeed)<0.0001) angleSpeed = 0;
    a += angleSpeed;
    x+=speedx;
    y+=speedy;
    float turnM = map(speedMag, 0, 10, 1, 0.2);
    interpolateA = lerp(interpolateA, targetAngle, elapsedTime*6*turnM);
  }

  void keyPress() {
    if (keyCode == 'w' || keyCode == 'W') {
      up = true;
    }
    if (keyCode == 's' || keyCode == 'S') {
      down = true;
    }
    if (keyCode == 'a' || keyCode == 'A') {
      left = true;
    }
    if (keyCode == 'd' || keyCode == 'D') {
      right = true;
    }
    if (keyCode == ' ') {
      space = true;
    }
  }

  void keyRelease() {
    if (keyCode == 'w' || keyCode == 'W') {
      up = false;
    }
    if (keyCode == 's' || keyCode == 'S') {
      down = false;
    }
    if (keyCode == 'a' || keyCode == 'A') {
      left = false;
    }
    if (keyCode == 'd' || keyCode == 'D') {
      right = false;
    }
    if (keyCode == ' ') {
      space = false;
    }
  }
}
