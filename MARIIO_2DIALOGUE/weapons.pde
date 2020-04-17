ArrayList<grenade> grenades = new ArrayList<grenade>();
class weapon {
  float range;
  boolean throwable;
  float cost;
}

class grenade extends weapon {
  float xPosition;
  float yPosition;
  float xspeed;
  float yspeed;
  int shrapnelAMT;
  float shrapnelDMG;
  boolean onGround;
  float r = 5;
  float t = 0;
  boolean finished = false;
  float bounciness = 0.5;
  int startframe;
  float angularVelocity;
  float a = 0;



  grenade(float x, float y, float xs, float ys, int sAMT, float sDMG) {
    xPosition = x;
    yPosition = y;
    xspeed = xs;
    yspeed = ys;
    shrapnelAMT = sAMT;
    shrapnelDMG = sDMG;
    startframe = frameCount;
    range = 250;
    cost = 50;
    throwable = true;
    angularVelocity = random(-0.5,0.5);
  }

  void update(float eTime) {

    t+=eTime;
    yspeed += 2000*eTime;
    //println(globaltimescaled%1);
    if (onGround)
    {
      xspeed += -1 * (xspeed * eTime);
      //if (abs(xspeed) < 0.01f)
      //xspeed = 0.0f;
    }
    float newxPosition = xPosition + xspeed * eTime;
    float newyPosition = yPosition + yspeed * eTime;

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

    if (t>grenadetime) {
      for (int i = 0; i<shrapnelAMT; i++) {
        projectile b = new projectile(xPosition, yPosition, (onGround?random(-PI+PI/8, -PI/8):random(0, TWO_PI)), (onGround?random(10, 600):random(0, 600)), shrapnelDMG, true, true, false);
        b.xspeed += xspeed*0.8;
        b.yspeed += yspeed*0.8;
        bullets.add(b);
      }
      finished = true;
    }

    xPosition = newxPosition;
    yPosition = newyPosition;
    a+=angularVelocity;
    noStroke();
    //tint(map(t, 0, 1, 0, 255), 0, 0);
    pushMatrix();
    translate(xPosition, yPosition);
    rotate(a);
    image(images.grenade,0, 0);
    
    popMatrix();
  }
}

void removeGrenades() {
  for (int i = grenades.size() - 1; i >= 0; i--) {
    grenade part = grenades.get(i);
    if (part.finished) {
      grenades.remove(i);
    }
  }
}




class Inventory {
  ArrayList<Islot> slots = new ArrayList<Islot>();
  int size=30;
  float sR = 64;
  boolean show = false;
  Inventory(int sizeE) {
    size = sizeE;
    for (int i = 0; i < size; i++) {
      slots.add(new Islot());
    }
    println(slots.size());
  }

  void show() {
    if (show) {
      timestep = 0.01;
      targetFade = 170;
      for (int i = 0; i<size; i++) {
        fill(0, 40);
        stroke(0, 255, 0);
        //rectMode(CENTER);
        float x = (((width-(sR)*slots.size())/2) + (sR)*(i%5))+32*6 + width/2;
        float y = 64+floor(i/5)*sR;
        rect(x, y, sR, sR);
        if (slots.get(i).storedItem.texture!=null) {
          image(slots.get(i).storedItem.texture, x, y, sR, sR);
        }
      }
    }
  }
}

class Islot {
  Iitem storedItem;
  Islot() {
    storedItem = new Iitem(0);
  }
}

class Iitem {
  PImage texture;
  PImage equipTexture = null;
  boolean isEquip = false;
  int itemID;
  Iitem(int ID) {
    texture = getImageFromId(ID);
    itemID = ID;
  }
  Iitem(int ID, boolean e, PImage t1) {
    texture = getImageFromId(ID);
    itemID = ID;
    isEquip = e;
    equipTexture = t1;
  }
}

PImage getImageFromId(int id) {
  switch(id) {
  case 1: 
    return images.grenadeICON;
  default: 
    return images.notexture;
  }
}



Iitem grenade;
void declareItems() {
  grenade = new Iitem(1, true, images.grenadeICON);
}
