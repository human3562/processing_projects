settingsA menuButtons;
void menu() {
  background(50);
  textSize(90);
  textAlign(CENTER);
  fill(255);
  text("TYPERR", width/2, 95);
  textSize(30);
  if (menuButtons.settings.get(0).act) {
    gameState = "SETUP";
  }
  if (menuButtons.settings.get(1).act) {
    exit();
  }
  menuButtons.show();
}

float fadeT = 0;
float fadeout = 0;
boolean reset = false;
void stats() {
  if (lerpT<transitionTime)                      
    lerpT+=elapsedTime;
  else {
    fadeT += elapsedTime;
  }
  background(50);

  fill(255);
  textAlign(LEFT);
  textSize(32);
  text("WPM: "+floor((wordAmt/time)*60), width/2-130, 134);
  text("Символов в минуту: "+floor((charAmt/time)*60), width/2-130, 166);
  textSize(16);
  text("Ошибок: "+mistakes, width/2-130, 166+32);
  text("Нажмите R для перезапуска. \nESC для возврата в меню.", width/2-130, 198+32);

  fill(50, map(fadeT, 0, transitionTime, 255, 0));
  noStroke();
  rectMode(CORNERS);
  rect(0, 0, width, height);

  fill(255);
  textSize(60);
  textAlign(CENTER);
  int min = floor(time/60);
  int sec = floor(time%60);
  int mlsec = floor((time - floor(time))*100);
  text(nf(min, 2)+":"+nf(sec, 2)+":"+nf(mlsec, 2), width/2, map(lerpT, 0, transitionTime, height/2, 70));

  if (reset) {
    fadeout += elapsedTime;
    fill(50, map(fadeout, 0, transitionTime/2, 0, 255));
    noStroke();
    rectMode(CORNERS);
    rect(0, 0, width, height);
    if (fadeout > transitionTime/2) {
      setupGame();
      gameState = "GAME";
    }
  }
}

boolean started = false;
float lerpT = 0;
float transitionTime = 2;
void mainGame() {
  background(50);
  noFill();
  strokeWeight(1);
  stroke(200);
  rectMode(CENTER);
  rect(width/2, height/2+6, width+2, 32);

  if (!words.isEmpty()) {
    if (words.size()>1) {
      for (int i = 0; i<2; i++) {
        words.get(i).update();
        words.get(i).show();
      }
    } else { 
      words.get(0).update(); 
      words.get(0).show();
    }
    removeWords();
    for (int i = 0; i<words.size(); i++) {
      words.get(i).id = i;
    }
  }
  if (!particles.isEmpty()) {
    for (particle p : particles) {
      p.update();
      p.show();
    }
    removeParticles();
  }

  strokeWeight(8);
  stroke(120);
  line(width-250, 52, width-20, 52);
  stroke(255);
  line(width-250, 52, width - map(typedWords, 0, wordAmt, 250, 20), 52);
  fill(255);
  textSize(22);
  textAlign(RIGHT);
  text(typedWords+"/"+wordAmt, width-20, 82);
  textSize(map(lerpT, 0, transitionTime, 32, 60));
  int min = floor(time/60);
  int sec = floor(time%60);
  int mlsec = floor((time - floor(time))*100);
  fill(50, map(lerpT, 0, transitionTime, 0, 255));
  noStroke();
  rectMode(CORNERS);
  rect(0, 0, width, height);
  fill(255);
  text(nf(min, 2)+":"+nf(sec, 2)+":"+nf(mlsec, 2), map(lerpT, 0, transitionTime, width-20, width/2+textWidth("00:00:00")/2), map(lerpT, 0, transitionTime, 35, height/2));
  textSize(12);
  textAlign(LEFT);
  text("FPS:"+frameRate, 10, 10);
  text("MISTAKES:"+mistakes, 10, 25);

  if (words.isEmpty()) {
    if (lerpT<transitionTime)
      lerpT += elapsedTime;
    else {
      gameState = "STATS";
      lerpT = 0;
    }

    //gameState = "STATS";
  }

  if (started)
    time+=elapsedTime;
}

void gameSetting() {
  background(50);
  textAlign(RIGHT);
  textSize(80);
  text("НАСТРОЙКИ ИГРЫ", width, 70);
  if (setupSettings.settings.get(setupSettings.settings.size()-1).act) {
    setupGame();
    gameState = "GAME";
  }
  setupSettings.show();
  //wordamt,seed,word reset on typo,auto enter,
}


boolean wrdrst = false;
boolean autent = false;
boolean progshake = false;
void setupGame() {
  amt = setupSettings.settings.get(setupSettings.settings.size()-2).value;
  ok = false;
  if (!particles.isEmpty())
    for (particle p : particles) {
      p.finished = true;
    }
  removeParticles();
  typedString = "";
  words.clear();
  words.add(new word("начать!"));
  for (int i = 0; i<amt; i++)
    words.add(new word(text[(int)random(text.length)]));
  wordAmt = words.size();
  reset = false;
  for (word w : words) {
    charAmt+=w.wordString.length();
  }
  wrdrst = setupSettings.settings.get(0).act;
  autent = setupSettings.settings.get(1).act;
  progshake = setupSettings.settings.get(2).act;

  mistakes = 0;
  typedWords = 0;
  time = 0;
  lerpT = 0;
  fadeT = 0;
  fadeout = 0;
}
