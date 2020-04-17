float offsetX, offsetY;
float elapsedTime = 0;
player p;
void setup() {
  //fullScreen();
  size(600, 600);
  p = new player();
  car = loadImage("car.png");
  wheel = loadImage("wheel.png");
  imageMode(CENTER);
  noSmooth();
}

void draw() {
  elapsedTime = 1/frameRate;

  offsetX = (p.x+p.speedx*4)-width/2;
  offsetY = (p.y+p.speedy*4)-height/2;

  background(80);
  //ellipse(p.x+p.speedx, p.y+p.speedy,10,10);
  pushMatrix();
  translate(-offsetX, -offsetY);
  
  drawGrid();
  p.update();
  p.show();
  ellipse(p.x+p.speedx, p.y+p.speedy, 10, 10);

  popMatrix();
  text("FPS: "+frameRate, 10, 10);
  text("Speed Magnitude: "+sqrt(p.speedx*p.speedx + p.speedy*p.speedy),10,25);
  text("Angle Speed: "+p.angleSpeed,10,40);
  
}

void drawGrid(){
  float leftBorder = p.x - width/2;
  float rightBorder = p.x + width/2;
  float upBorder = p.y - height/2;
  float downBorder = p.y + height/2;
  stroke(100);
  for (int i = int(leftBorder); i<rightBorder; i++) {
    if (abs(i)%100 == 1) {
      line(i, upBorder, i, downBorder);
    }
  }
  for (int i = int(upBorder); i<downBorder; i++) {
    if (abs(i)%100 == 1) {
      line(leftBorder, i, rightBorder, i);
    }
  } 
}
