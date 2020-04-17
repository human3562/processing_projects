float throwX = 0;
float throwY = 0;
float mposX = 0;
float mposY = 0;
float ta = 0;
float td = 0;

class player {
  Inventory inventory;
  ArrayList<popup> popups = new ArrayList<popup>();
  float xPosition = 64;
  float yPosition = 64;
  float newxPosition;
  float newyPosition;
  float xspeed = 0;
  float yspeed = 0;
  float maxHp = 100;
  float hp = 100;
  float moveSpeed;
  float h = 64;
  float w = 32;
  float maxSpeed = 500;
  float acc = 6500;
  int gold = 0;
  boolean canMove;
  boolean isDead;
  boolean up, down, left, right;
  boolean onGround = true;
  float jumpspeed = 800;
  boolean onLadder = false;
  //float ass = 0;
  boolean jetpack = true;
  float t = 0;

  PImage currentTextureTop;
  PImage currentTextureBot;
  boolean flipTexture = false;
  int curtxtId;

  float AFKtime = 0;
  PImage lastWheelz;
  boolean jumped = false;
  float jumpT = 0;

  float jetpackT;

  float walkedPixels = 0;
  float pixelsPerFrame = 6.4;

  player() {
    inventory = new Inventory(20);

    //walk[2] = images.playerWalk3;
    //walk[3] = images.playerWalk4;

    currentTextureTop = images.playerIdle;
    lastWheelz = images.playerWalk[0];
    inventory.slots.get(0).storedItem = grenade;
  }


  void update() {
    //yspeed = 0;
    //xspeed = 0;
    if (hp<=0)
      isDead = true;
    else isDead = false;

    if (isDead) canMove = false;
    else canMove = true;
    if (inventory.show)
      canMove = false;
    if (cutscenes.isEmpty())
      yspeed+=2000*elapsedTime;
    if (canMove) {
      if (jetpack) {
        if (up) {
          yspeed-=acc *elapsedTime;
          if (t > 0.001) {
            for (int i = 0; i<10; i++) {
              particles.add(new particle(xPosition+(flipTexture?12:-12), yPosition+15, random(-10, 10), random(900, 1000), 1000, 0.05, color(random(10, 200)), 3));
            }
            t = 0;
          }
        }
      } else {
        if (up && onLadder) {
          yspeed = -200;
          xspeed = 0;
        }
      }


      //if (down &&!onGround) {
      //  
      //}

      if (left && xspeed>-maxSpeed) {
        xspeed -= ((onGround)?acc:400) * elapsedTime;
        if (xspeed<-maxSpeed && onGround) xspeed = -maxSpeed;
      }
      if (right && xspeed<maxSpeed) {
        xspeed += ((onGround)?acc:400) * elapsedTime;
        if (xspeed>maxSpeed && onGround) xspeed = maxSpeed;
      }
    }
    if (onGround)
    {
      if (abs(xspeed)>0 && !left && !right) {
        xspeed += map(xspeed, -maxSpeed, maxSpeed, acc/4, -acc/4)*elapsedTime;
      }
      //xspeed += -8 * xspeed * elapsedTime;
      if (abs(xspeed) < 0.1f)
        xspeed = 0.0f;
    }
    if (!cutscenes.isEmpty()) {
      xspeed = 0;
    }

    if (xspeed>5000) xspeed = 5000;
    if (xspeed<-5000) xspeed = -5000;
    if (yspeed>5000) yspeed = 5000;
    if (yspeed<-5000) yspeed = -5000;
    newxPosition = xPosition + xspeed * elapsedTime;
    newyPosition = yPosition + yspeed * elapsedTime;

    currentTextureTop = images.playerIdle;
    //currentTextureBot = images.playerWalk[0];


    float pixelsTravelledX = newxPosition-xPosition;
    walkedPixels += abs(pixelsTravelledX);
    curtxtId = (ceil((walkedPixels / pixelsPerFrame) % images.playerWalk.length))-1;
    //println(curtxtId);
    if (curtxtId<0) curtxtId = 0;
    currentTextureTop = images.playerIdle;
    currentTextureBot = images.playerWalk[curtxtId];
    lastWheelz = currentTextureBot;

    if (xspeed == 0) {
      AFKtime += elapsedTime;
    } else AFKtime = 0;

    if (jumped) {
      int f = (ceil(((jumpT) / 0.03)));
      if (f>images.playerJump.length-1) f = images.playerJump.length-1;
      currentTextureTop = images.playerJump[f];
      jumpT+=elapsedTime;
      if (yspeed>=0) {
        jumped = false;
        jumpT = 0;
      }
    } 
    //if(lastWheelz!=null) currentTextureBot = lastWheelz;

    t+=elapsedTime;
    detectCollisions();
  }

  void drawHolo(float T) {
    if (T > 5) {
      int f = 0;
      if (T<10) {
        f = ceil(((AFKtime-5) / 0.03))-1;
        if (f>23) f = 23;
      }else{
        f = 22 - ceil(((AFKtime-10) / 0.03));
        if(f<0){
          f = 0;
          AFKtime = 0;
        }
      }
      println(f);
      image(images.playerHolo[f], 0, 0);
    }
  }

  void drawJetpack(float T) {
    if (up) {
      println(T);
      int currentFrame = ceil(((T) / 0.06));
      if (currentFrame>4) {
        int f = (ceil((currentFrame / 0.016) % 3));
        image(images.playerJetpack[4+f], 0, 0);
      } else {
        image(images.playerJetpack[currentFrame], 0, 0);
      }
    } else {
      image(images.playerJetpack[0], 0, 0); 
      jetpackT = 0;
    }
  }

  void show() {
    pushMatrix();
    translate(xPosition, yPosition);
    scale((flipTexture ? -1 : 1), 1);
    tint((isDead)?color(100, 0, 0) : 255);
    image(currentTextureTop, 0, 0);
    image(currentTextureBot, 0, 0);
    if (jetpack) {
      drawJetpack(jetpackT);
      jetpackT+=elapsedTime;
    }
    noTint();
    popMatrix();

    if (AFKtime > 5) {
      pushMatrix();
      translate(xPosition, yPosition);
      drawHolo(AFKtime);
      popMatrix();
    }

    noFill();
    strokeWeight(1);
    //rect(xPosition, yPosition, w, h);
    strokeWeight(4);
    stroke(0);
    line(xPosition-32-1, yPosition-32-5, xPosition+32+1, yPosition-32-5);
    strokeWeight(2);
    stroke(50);
    line(xPosition-32, yPosition-32-5, xPosition+32, yPosition-32-5);
    stroke(0, 255, 0);
    //line(xPosition,yPosition,xPosition+xspeed,yPosition+yspeed);
    if (hp>0) {
      line(xPosition-32, yPosition-32-5, map(hp, 0, maxHp, xPosition-32, xPosition+32), yPosition-32-5);
    }
    if (!popups.isEmpty()) {
      for (popup p : popups) {
        p.update();
      }
      for (int i = popups.size() - 1; i >= 0; i--) {
        popup part = popups.get(i); 
        if (part.finished) {
          popups.remove(i);
        }
      }
    }
  }

  void takeDamage(float dmg) {
    popups.add(new popup(xPosition, yPosition, dmg, false)); 
    boom(xPosition, yPosition, int(dmg), color(255, 0, 0)); 
    hp-=dmg; 
    if (hp<0) hp = 0;
  }

  void heal(float amount) {
    popups.add(new popup(xPosition, yPosition, amount, true)); 
    hp+=amount; 
    if (hp>maxHp) hp = maxHp;
  }

  void detectCollisions() {

    onLadder = false; 
    if (levels.get(currentLevel).blocks.get(GetTile(int(xPosition), int(yPosition))).ladder ==true) {
      onLadder = true;
    }
    if (xspeed<0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(yPosition-h/2))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(yPosition-h/2))).positionX + 32+w/2; 
        xspeed = 0;
      }
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(yPosition+h/2-2))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(yPosition+h/2))).positionX + 32+w/2; 
        xspeed = 0;
      }
    }
    if (xspeed>0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(yPosition-h/2))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(yPosition-h/2))).positionX - 32-w/2; 
        xspeed = 0;
      }
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(yPosition+h/2-2))).isSolid) {
        newxPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(yPosition+h/2))).positionX - 32-w/2; 
        xspeed = 0; 
        //println("AS");
      }
    }
    onGround = false; 
    if (yspeed<0) {
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(newyPosition-h/2))).isSolid) {
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(newyPosition-h/2))).positionY + 32+h/2; 
        yspeed = 0; 
        //println("ass");
      }
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2-2), floor(newyPosition-h/2))).isSolid) {
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(newyPosition-h/2))).positionY + 32+h/2; 
        yspeed = 0; 
        //println("ass2");
      }
    }
    if (yspeed>0) {
      //println("wrong");
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2-2), floor(newyPosition+h/2))).isSolid) {
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition+w/2), floor(newyPosition+h/2))).positionY - 32-h/2; 
        if (yspeed>1200) {
          takeDamage(map(yspeed, 1200, 5000, 15, maxHp*3));
        }
        yspeed = 0; 
        onGround = true;
      }
      if (levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(newyPosition+h/2))).isSolid) {
        newyPosition = levels.get(currentLevel).blocks.get(GetTile(floor(newxPosition-w/2), floor(newyPosition+h/2))).positionY - 32-h/2; 
        if (yspeed>1200) {
          takeDamage(map(yspeed, 1200, 5000, 15, maxHp*3));
        }
        yspeed = 0; 
        onGround = true;
      }
    }

    xPosition = newxPosition; 
    yPosition = newyPosition;
  }
}
