ArrayList<word> words = new ArrayList<word>();
class word {
  String wordString = "";
  float x = width/2, y = -height;
  int id = -1;
  boolean killed = false;
  boolean toShake = false;
  boolean active = false;
  float shake = 20;
  float t = 0;

  word(String _word) {
    wordString = _word;
  }

  void update() {
    if (id<2) {
      shake *= (progshake?1:0);
      float desiredY = height/2 - 64 * id + random(-map(typedWords, 0, 50, 0, 1), map(typedWords, 0, 50, 0, 1)) * shake;
      //float desiredX = width/2 + random(-1,1) * shake;
      float desiredX = width/2 + random(-map(typedWords, 0, 50, 0, 1), map(typedWords, 0, 50, 0, 1)) * shake;
      x = lerp(x, desiredX, elapsedTime*6);
      y = lerp(y, desiredY, elapsedTime*6);
      if (toShake) {
        t += elapsedTime;
        x+=random(-4, 4);
        y+=random(-4, 4);
        if (t>0.1) {
          t = 0;
          toShake = false;
        }
      }
    }
  }

  void show() {
    if (y>-32) {
      textSize(32);
      textAlign(CENTER, CENTER);
      fill(200, 0, 0);
      text(wordString, x, y);
      if (id == 0) {
        float w = textWidth(wordString);
        textAlign(LEFT, CENTER);
        fill(0, 255, 0);
        text(typedString, x-w/2, y);
      }
    }
  }

  void shake() {
    toShake = true;
  }

  void kill() {
    float w = textWidth(wordString);
    //String s = "";
    float px = 0;
    for (int i = 0; i<wordString.length(); i++) {
      //s+=wordString.charAt(i);
      float X = ((width/2 - w) + px);
      px += textWidth(wordString.charAt(i))*2;
      float Y = y;
      particles.add(new particle(wordString.charAt(i), X, Y));
    }
    killed = true;
  }
}

void removeWords() {
  for (int i = words.size() - 1; i >= 0; i--) {
    word part = words.get(i);
    if (part.killed) {
      words.remove(i);
    }
  }
}
