class turret {
  float xPosition;
  float yPosition;
  float r;
  float dmg;
  float t;
  float time;
  float hp = 100;
  boolean canShoot = false;
  boolean finished = false;
  float bulspeed = 600;
  turret(float x, float y, float _r, float _time, float _dmg) {
    xPosition = x;
    yPosition = y;
    r = _r;
    time = _time; 
    t = _time;
    dmg = _dmg;
  }
  void update() {
    t+=elapsedTime;
    if (hp<=0) {
      explode();
    }
    float distance = dist(Player.xPosition, Player.yPosition, xPosition, yPosition);
    if (distance<=r) {
      canShoot = true;

      //float a = atan2((Player.yPosition+Player.yspeed*elapsedTime*120) - yPosition, (Player.xPosition+Player.xspeed*elapsedTime*120) - xPosition);

      float v = bulspeed;
      float tx = Player.xPosition + Player.xspeed;
      float ty = Player.yPosition + Player.yspeed;
      float s1 = dist(xPosition, yPosition, tx, ty);
      float t1 = (s1/v);
      float s2 = dist(xPosition,yPosition,Player.xPosition+Player.xspeed*t1,Player.yPosition+Player.yspeed*t1);
      float t2 = (s2/v);
      //float s2 = sqrt(Player.xspeed*Player.xspeed+Player.yspeed*Player.yspeed) * t;
      text(t2, -offsetX+200, -offsetY+10);
      float a = atan2((Player.yPosition+(Player.yspeed*t2))-yPosition, (Player.xPosition+(Player.xspeed*t2))-xPosition);
      //line(xPosition,yPosition,Player.xPosition+Player.xspeed*ti,Player.yPosition + Player.yspeed * ti);
      float ca = atan2((Player.yPosition) - yPosition, (Player.xPosition) - xPosition);
      if (canShoot) {
        for (int i = 0; i<distance; i++) {
          float cX = xPosition + cos(ca) * i;
          float cY = yPosition + sin(ca) * i;
          if (levels.get(0).blocks.get(GetTile(int(cX), int(cY))).isSolid) {
            canShoot = false;
            break;
          }
        }
      }
      strokeWeight(1);
      if (canShoot) {
        stroke(255, 0, 0, 100);
        line(xPosition, yPosition, Player.xPosition, Player.yPosition);
        fill(255, 0, 0, 100);
        ellipse(Player.xPosition, Player.yPosition, 10, 10);
      }
      if (canShoot && t>time && !Player.isDead) {
        bullets.add(new projectile(xPosition, yPosition, a, bulspeed, dmg, false, false, true));
        t=0;
      }
    }

    image(images.turret, xPosition, yPosition, 64, 64);
    noFill();
    stroke(100, 100);
    ellipse(xPosition, yPosition, r*2, r*2);
    if (hp>0) {
      line(xPosition-32, yPosition-32-5, map(hp, 0, 100, xPosition-32, xPosition+32), yPosition-32-5);
    }
  }

  void explode() {
    for (int i = 0; i<100; i++) {
      boom(xPosition, yPosition, 10, color(25));
    }
    finished = true;
  }

  void takeDamage(float dmg) {
    boom(xPosition, yPosition, 10, color(50)); 
    hp-=dmg; 
    if (hp<0) hp = 0;
  }
}

void removeTurrets() {
  for (int i = turrets.size() - 1; i >= 0; i--) {
    turret part = turrets.get(i);
    if (part.finished) {
      turrets.remove(i);
    }
  }
}
