PVector Vwind;
float maxWindV = 20;

PVector G = new PVector(0, 9.81);

float windBallX; 
float windBallY;

float camX;
float camY;

int PROGRAM_STATE = 1; 
//0 - playground;
//1 - launchsetting;
//2 - simulating;

s_playground playground;
s_launchSetting launchSetting;
s_review review;

void setup() {
  size(1200, 600, P2D); 
  smooth(4);
  //fullScreen(1);
  camX = -width/2;
  camY = -height/2;
  //float d = random(0, maxWindV);
  //float a = random(0, TWO_PI);
  //Vwind = new PVector(cos(a)*0, sin(a)*0);
  //ball = new body();
  playground = new s_playground();
  launchSetting = new s_launchSetting();
  review = new s_review();
}

void draw() {
  switch(PROGRAM_STATE) {
  case 0:
    if (!playground.isStarted) {
      playground.Start();
      playground.isStarted = true;
    } else {
      playground.Update();
    }
    break;
  case 1:
    if (!launchSetting.isStarted) {
      launchSetting.Start();
      launchSetting.isStarted = true;
    } else {
      launchSetting.Update();
    }
    break;
  case 2:
    if (!review.isStarted) {
      review.Start();
      review.isStarted = true;
    } else {
      review.Update();
    }
    break;
  default: 
    PROGRAM_STATE = 0;
    break;
  }
}

void drawMap() {
  strokeWeight(1);
  stroke(40);
  for (int i = floor((camX)/pixelScale); i < ceil((camX+width)/pixelScale); i+=1) {
    line(i*pixelScale, camY, i*pixelScale, camY+height);
  }
  for (int i = floor(camY/pixelScale); i < ceil((camY+height)/pixelScale); i+=1) {
    line(camX, i*pixelScale, camX+width, i*pixelScale);
  }
}

void info(body ball) {
  fill(0);
  stroke(100);
  strokeWeight(1);
  rectMode(CORNERS);
  rect(-1, -1, 280, 100);
  fill(255);
  textAlign(LEFT);
  textSize(10);
  text("FPS: "+nfc(frameRate, 2), 10, 10);
  text("Координата X: "+ nfc(ball.position.x, 2) +"m;", 10, 25);
  text("Координата Y: "+nfc(ball.position.y, 2)+"m", 130, 25);
  text("Скорость X: "+nfc(ball.velocity.x, 2)+"m/s;", 10, 40);
  text("Скорость Y: "+nfc(ball.velocity.y, 2)+"m/s", 130, 40);
  text("Ускорение X: "+nfc(ball.acceleration.x, 2)+"m/s²;", 10, 55);
  text("Ускорение Y: "+nfc(ball.acceleration.y, 2)+"m/s²", 130, 55);
  text("Высота: "+nfc(ball.groundLevel - ball.position.y, 2)+"m", 10, 70);
}


boolean settingWind = false;
void drawWindDirection(body ball, float x, float y, boolean canChange) {

  if (settingWind && canChange == true) {
    if (dist(mouseX, mouseY, windBallX, windBallY) < 100) {
      float sx = -(windBallX - mouseX)/100;
      float sy = -(windBallY - mouseY)/100;
      Vwind.x = maxWindV * sx;
      Vwind.y = maxWindV * sy;
    }
  }

  noStroke(); 
  fill(0);
  ellipse(x, y, 200, 200);
  fill(255);
  ellipse(x, y, 15, 15);
  noFill();
  stroke(255);
  strokeWeight(1);
  ellipse(x, y, 200, 200);

  pushMatrix();
  translate(x, y);
  float a = atan2(Vwind.y, Vwind.x) + HALF_PI;
  rotate(a);
  float ypos = map(Vwind.mag(), 0, maxWindV, 0, -100);
  strokeWeight(2);
  line(0, 0, 0, ypos);
  fill(255);
  beginShape();
  vertex(0, ypos);
  vertex(5, ypos+10);
  vertex(-5, ypos+10);
  endShape(CLOSE);
  popMatrix();

  fill(200);
  textAlign(CENTER);
  textSize(20);
  text(nfc(Vwind.mag(), 2)+"m/s", x, y+50);

  fill(255);
  textAlign(RIGHT);
  textSize(23);
  text("Направление ветра", x+100, y+130);
}
