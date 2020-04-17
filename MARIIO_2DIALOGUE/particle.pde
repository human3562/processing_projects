ArrayList<particle> particles = new ArrayList<particle>();
class particle {
  float xPosition;
  float yPosition;
  float xspeed;
  float yspeed;
  float t;
  float tmax;
  boolean finished;
  float w = 1.5;
  color c = color(255, 0, 0);
  particle(float _xPosition, float _yPosition, float xsp, float ysp, float maxsp, float lifeTime, color _c) {
    xPosition = _xPosition;
    yPosition = _yPosition;
    float a = atan2(ysp, xsp);
    xspeed = cos(a) * random(10, maxsp) + random(-80, 80);
    yspeed = sin(a) * random(10, maxsp) + random(-80, 80);
    tmax = lifeTime;
    t = lifeTime;
    c = _c;
  }
  particle(float _xPosition, float _yPosition, float xsp, float ysp, float maxsp, float lifeTime, color _c, float _w) {
    xPosition = _xPosition;
    yPosition = _yPosition;
    float a = atan2(ysp, xsp);
    xspeed = cos(a) * random(10, maxsp) + random(-80, 80);
    yspeed = sin(a) * random(10, maxsp) + random(-80, 80);
    tmax = lifeTime;
    t = lifeTime;
    c = _c;
    w = _w;
  }

  void update() {
    yspeed += 2000*elapsedTime;
    xPosition += xspeed * elapsedTime;
    yPosition += yspeed * elapsedTime;
    if (levels.get(currentLevel).blocks.get(GetTile(int(xPosition), int(yPosition))).isSolid) {
      finished = true;
    } else {
      if (onScreen(xPosition, yPosition, 0) && !finished) {
        tint(c, map(t,tmax,0,255,0));
        image(images.dirt, xPosition, yPosition, w, w);
        noTint();
      }
      t-=elapsedTime;
      if (t<0)
        finished = true;
    }
  }
}

class pathP {
  float xPosition;
  float yPosition;
  float xspeed;
  float yspeed;
  float t = 1;
  float tmax;
  boolean finished;
  color c = color(255, 0, 0);
  boolean onGround = false;
  float bounciness = 0.5;
  float r = 5;
  pathP(float _xPosition, float _yPosition, float xsp, float ysp, float lifeTime, color _c) {
    xPosition = _xPosition;
    yPosition = _yPosition;
    float a = atan2(ysp, xsp);
    float max = sqrt(ysp*ysp+xsp*xsp);
    xspeed = cos(a) * max;
    yspeed = sin(a) * max;
    tmax = lifeTime;
    t = lifeTime;
    c = _c;
  }

  void update(float eTime) {
    t-=eTime;
    yspeed += 2000*eTime;
    if (onGround)
    {
      xspeed += -1 * (xspeed*eTime);
      //  if (abs(xspeed) < 0.01f)
      //    xspeed = 0.0f;
    }
    float newxPosition = xPosition + xspeed*eTime;
    float newyPosition = yPosition + yspeed*eTime;

    if (xspeed < 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-r), floor(yPosition))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-r), floor(yPosition))).positionX + 37;
        xspeed=-(xspeed*bounciness);
      }
    } 
    if (xspeed>0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+r), floor(yPosition))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+r), floor(yPosition))).positionX-37;
        xspeed=-(xspeed*bounciness);
      }
    }
    onGround = false;
    if (yspeed < 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition), floor(newyPosition-r))).isSolid) {
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition), floor(newyPosition-r))).positionY+37;
        yspeed=-(yspeed*bounciness);
      }
    } 
    if (yspeed > 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition), floor(newyPosition+r))).isSolid) {
        onGround = true;
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+r), floor(newyPosition+r))).positionY-37;
        yspeed=-(yspeed*bounciness);
      }
    }
    if (t<=0)
      finished = true;
    xPosition = newxPosition;
    yPosition = newyPosition;
    //if (onScreen(xPosition, yPosition, 0) && !finished) {
    //stroke(c);
    //point(xPosition,yPosition);
    //}
    //if (t<=0)
    //  finished = true;
  }
}

void boom(float x, float y, int partAmount, int life, color c) {
  for (int i = 0; i<partAmount; i++) {
    float a = random(0, TWO_PI);
    particles.add(new particle(x, y, cos(a), sin(a), random(10, 400), life, c));
  }
}

void boom(float x, float y, int partAmount, color c) {
  for (int i = 0; i<partAmount; i++) {
    float a = random(0, TWO_PI);
    particles.add(new particle(x, y, cos(a), sin(a), random(10, 400), 5, c));
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
