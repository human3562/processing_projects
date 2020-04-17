class popup {
  float xPosition;
  float yPosition;
  float amount;
  float t = 3;
  float a = t;
  float f = random(-500, 500);
  boolean finished;
  boolean heal = false;

  popup(float x, float y, float dmg, boolean _heal) {
    xPosition = x;
    yPosition = y;
    amount = dmg;
    heal = _heal;
    f+=Player.xspeed * elapsedTime;
  }

  void update() {
    textAlign(CENTER);
    fill((heal)? color(0, 200, 0, map(a, 0, t, 0, 255)) : color(255, 0, 0, map(a, 0, t, 0, 255)));
    a-=elapsedTime;
    if (!heal)
      text(round(amount)+" DMG", xPosition, yPosition);
    else text("+"+round(amount)+" HP", xPosition, yPosition);

    yPosition-=100 * elapsedTime;
    xPosition+=f * elapsedTime;
    f += -8 * f * elapsedTime;
    if (abs(f) < 0.01f)
      f = 0.0f;
    if (a<0)
      finished = true;
  }
}
