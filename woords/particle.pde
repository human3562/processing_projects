ArrayList<particle> particles = new ArrayList<particle>();
float lifeTime = 2;
class particle {
  float x, y;
  float speedX = 0;
  float speedY = 0;
  float t = 0;
  char c;
  boolean finished = false;
  float angle = 0;
  float aSpeed = 0;
  particle(char _c, float _x, float _y) {
    c = _c;
    x = _x;
    y = _y;
    float a = random(0, TWO_PI);
    speedX = cos(a) * random(5, 500);
    speedY = sin(a) * random(5, 500);
    aSpeed = random(-TWO_PI, TWO_PI);
  }

  void update() {
    t+=elapsedTime;
    speedY += 9.8;
    x += speedX * elapsedTime;
    y += speedY * elapsedTime;
    angle += aSpeed * elapsedTime;
    if (t>lifeTime) {
      finished = true;
    }
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    fill(0, 255, 0, map(t, 0, lifeTime, 255, 0));
    textSize(32);
    text(c, 0, 0);
    popMatrix();
  }
}

void removeParticles() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    particle part = particles.get(i);
    if (part.finished) {
      particles.remove(i);
    }
  }
}
