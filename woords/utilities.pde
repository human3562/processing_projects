boolean ok = false;
void keyPressed() {
  //text += key;
  if (keyCode == ESC) {
    key = 0;
    gameState = "MENU";
  }
  if (gameState == "MENU") {
    menuButtons.update();
  }

  if (gameState == "SETUP") {
    setupSettings.update();
    if (keyCode == 'e' || keyCode == 'E') {
      setupGame();
      gameState = "GAME";
    }
  }

  if (gameState == "STATS") {
    if (keyCode == 'r' || keyCode == 'R') {
      reset = true;
    }
    if (key == ENTER || key == RETURN) {
      lerpT = transitionTime;
      fadeT = transitionTime;
    }
  }
  if (gameState == "GAME") {
    //if (key == ' ') {
    //  if (!words.isEmpty())
    //    words.get(0).shake();
    //}
    if (key == ENTER) {
      if (!words.isEmpty()) {
        if (ok) {
          words.get(0).kill();
          typedWords++;
          ok = false;
          typedString = "";
          if (!started) started = true;
          if (words.size() == 1) started = false;
        } else words.get(0).shake();
      } else {
        lerpT = transitionTime;
      }
    } else
      if (key == BACKSPACE) {
        if (typedString.length()>0)
          typedString = typedString.substring(0, typedString.length()-1);
      } else if (key != RETURN && keyCode != SHIFT && key != TAB && keyCode!=CONTROL && keyCode!=ALT && !words.isEmpty()) {
        String temp = typedString+key;
        if (temp.length() > words.get(0).wordString.length()) temp = "NULL";
        //println(temp.contains(words.get(0).wordString.substring(0, temp.length())));
        if (temp.contains(words.get(0).wordString.substring(0, temp.length()))) {
          //print("ASD");
          typedString += key;
          if (temp.length() == words.get(0).wordString.length()) ok = true; 
          else ok = false;
        } else {
          if (wrdrst) typedString = "";
          mistakes++;
          words.get(0).shake();
        }
      }
    if (autent) {
      if (ok) {
        words.get(0).kill();
        typedWords++;
        ok = false;
        typedString = "";
        if (!started) started = true;
        if (words.size() == 1) started = false;
      }
    }
  }
}
void mousePressed() {
  if (gameState == "MENU") {
    menuButtons.mouseUpdate();
  }
  if (gameState == "SETUP") {
    setupSettings.mouseUpdate();
  }
}
