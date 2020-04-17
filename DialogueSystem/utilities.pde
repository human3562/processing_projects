void keyPressed() {
  if (talkto!=-1) {
    if (key == 's') {
      if (characters.get(talkto).questions.get(characters.get(talkto).currentQ).answers!=null) {
        if (selectedA<characters.get(talkto).questions.get(fish.currentQ).answers.size()-1) {
          selectedA++;
        }
      }
    }
    if (key == 'w') {
      if (selectedA>0) {
        selectedA--;
      }
    }
    if (key == ENTER) {
      if (characters.get(talkto).questions.get(characters.get(talkto).currentQ).answers!=null) {
        characters.get(talkto).say();
      }
    }
  } else {
    if (key == 's') {
      if (!characters.isEmpty()) {
        if (selectedA<characters.size()) {
          selectedA++;
        }
      }
    }
    if (key == 'w') {
      if (selectedA>0) {
        selectedA--;
      }
    }
    if (key == ENTER) {
      if (!characters.isEmpty()) {
        talkto = selectedA;
        selectedA = 0;
        characters.get(talkto).showChar();
      }
    }
  }
}
