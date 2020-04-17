ArrayList<projectile> bullets = new ArrayList<projectile>();
class projectile {
  float xPosition;
  float yPosition;
  float xspeed;
  float yspeed;
  //boolean isExplosive = false;
  boolean gravity = false;
  float dmg;
  boolean finished = false;
  boolean castByPlayer = false;
  int hitside = 0;
  PImage texture;
  float r = random(-55, 55);
  float a = 0;
  boolean isBullet = false;

  projectile(float x, float y, float a, float speed, float d, boolean grav, boolean castPlayer, boolean isbullet) {
    xPosition = x;
    yPosition = y;
    xspeed = cos(a) * speed;
    yspeed = sin(a) * speed;
    dmg = d;
    gravity = grav;
    castByPlayer = castPlayer;
    isBullet = isbullet;
    if (isbullet) {
      texture = images.bullet;
    } else
      texture = images.fragments.get(floor(random(0, images.fragments.size())));
  }
  void update() {
    if (gravity)
      yspeed += 1000 * elapsedTime;

    //if (levels.get(0).blocks.get(GetTile(int(xPosition), int(yPosition))).isSolid) {
    //  for (int i = 0; i<50; i++) {
    //    particles.add(new particle(xPosition, yPosition, random(0, TWO_PI), 5, color(0)));
    //  }
    //  finished = true;
    //}

    if (xPosition<0||xPosition>levels.get(0).levelWidth*64||yPosition<0||yPosition>levels.get(0).levelHeight*64) finished = true;
    if (castByPlayer && !turrets.isEmpty()) {
      for (turret t : turrets) {
        if (dist(xPosition, yPosition, t.xPosition, t.yPosition)<=32) {
          t.takeDamage(dmg);
          finished = true;
        }
      }
    }
    if (collidesWithPlayer(xPosition, yPosition)) {
      Player.takeDamage(dmg);
      float speed = sqrt(xspeed*xspeed + yspeed*yspeed) * 0.2;
      float a = atan2(Player.yPosition - yPosition, Player.xPosition - xPosition);
      if (abs(Player.xspeed)<1500)
        Player.xspeed += cos(a)*speed;
      if (abs(Player.yspeed)<1500)
        Player.yspeed += sin(a)*speed;
      finished = true;
    }
    if (!characters.isEmpty()) {
      for (character c : characters) {
        if (dist(xPosition, yPosition, c.xPosition, c.yPosition)>150) continue; 
        if (xPosition>c.xPosition-c.w/2 && xPosition<c.xPosition+c.w/2 && yPosition>c.yPosition-c.h/2 && yPosition<c.yPosition+c.h/2) {
          c.takeDamage(dmg);
          float speed = sqrt(xspeed*xspeed + yspeed*yspeed) * 0.2;
          float a = atan2(c.yPosition - yPosition, c.xPosition - xPosition);
          if (abs(c.xspeed)<500)
            c.xspeed += cos(a)*speed;
          if (abs(c.yspeed)<500)
            c.yspeed += sin(a)*speed;
          finished = true;
        }
      }
    }


    float newxPosition = xPosition + xspeed * elapsedTime;
    float newyPosition = yPosition + yspeed * elapsedTime;
    boolean hit = false;
    if (xspeed < 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-2), floor(yPosition))).isSolid) {
        hit = true;
        hitside = 1;
      }
    } 
    if (xspeed>0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+2), floor(yPosition))).isSolid) {
        hit = true;
        hitside = 2;
      }
    }
    if (yspeed < 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition), floor(newyPosition-2))).isSolid) {
        hit = true;
        hitside = 3;
      }
    } 
    if (yspeed > 0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition), floor(newyPosition+2))).isSolid) {
        hit = true;
        hitside = 4;
      }
    }
    if (hit) {
      for (int i = 0; i<10; i++) {
        float xsp = 0;
        float ysp = 0;
        if (hitside == 1||hitside == 2) {
          xsp = -xspeed;
          ysp = yspeed;
        } else {
          xsp = xspeed;
          ysp = -yspeed;
        }

        particles.add(new particle(xPosition, yPosition, xsp, ysp, sqrt(xspeed*xspeed+yspeed*yspeed) * 0.6, 5, color(0)));
      }
      finished = true;
    }
    xPosition = newxPosition;
    yPosition = newyPosition;
    if (onScreen(xPosition, yPosition, 2) && !finished) {
      if (!isBullet) {
        pushMatrix();
        translate(xPosition, yPosition);
        rotate(a);
        fill(183, 183, 0);
        //noStroke();
        //stroke(0);
        //strokeWeight(1);
        //ellipse(xPosition, yPosition, 4, 4);
        image(texture, 0, 0);
        //ellipse(xPosition,yPosition,4,4);
        popMatrix();
        a+=r*elapsedTime;
      } else {
        pushMatrix();
        translate(xPosition, yPosition);
        float ba = atan2(yspeed, xspeed);
        rotate(ba);
        image(texture, 0, 0);
        popMatrix();
      }
    }
  }
}

void removeBullets() {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    projectile part = bullets.get(i);
    if (part.finished) {
      bullets.remove(i);
    }
  }
}
