float orX, orY;
void mousePressed() {
  if (PROGRAM_STATE == 0) {
    //playground.someButtons.update();
    if (playground.ball.mouseOver() && mouseButton == LEFT) {
      playground.ball.mouseMove = true;
    }
    if (dist(mouseX, mouseY, windBallX, windBallY) < 100 && mouseButton == LEFT) {
      settingWind = true;
    }
    if (mouseButton == RIGHT) {
      orX = mouseX + camX; 
      orY = mouseY + camY;
      println(orX + " " + orY);
    }
  }
  if(PROGRAM_STATE == 2){
    if(review.replay.mOver()){
      review.replay.mousePress = true;
    }
    if (mouseButton == RIGHT) {
      orX = mouseX + camX; 
      orY = mouseY + camY;
      println(orX + " " + orY);
    }
  }
}

void mouseDragged() {
  if (PROGRAM_STATE == 0 || PROGRAM_STATE == 2) {
    if (mouseButton == RIGHT) {
      camX = -mouseX+orX;
      camY = -mouseY+orY;
    }
  }
}

void mouseReleased() {
  if (PROGRAM_STATE == 0) {
    if (mouseButton == LEFT)
      playground.ball.mouseMove = false;
    settingWind = false;
  }
  if(PROGRAM_STATE == 2){
    review.replay.mousePress = false; 
  }
}

void mouseWheel(MouseEvent event) {
  float pmx = mouseX + camX;
  float pmy = mouseY + camY;

  pixelScale -= event.getCount() * 0.5;
  if (pixelScale>80) pixelScale = 80;
  if (pixelScale<1) pixelScale = 1;

  camX += pmx - (mouseX + camX);
  camY += pmy - (mouseY + camY);
}

void keyPressed(){
  if(PROGRAM_STATE == 1){
    launchSetting.setupSettings.update(); 
  }
  if(key == ESC && (PROGRAM_STATE == 0 || PROGRAM_STATE == 2)){
    key = 0;
    review.isStarted = false;
    PROGRAM_STATE = 1; 
    playground.isStarted = false;
  }
}
