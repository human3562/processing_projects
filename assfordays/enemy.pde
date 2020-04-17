class hero {
  ArrayList<Command> events = new ArrayList<Command>();
  float hp = 100;
  float maxhp;
  float dmg = 10;
  float hit = 0;
  float armor = 5;
  float x = 0;
  float y = 0;
  float a = 0;
  float attackRange = 50;
  float maxspeed = 250;
  float attackSpeed = 1;
  float t = 0;
  float r = 10;
  String name;
  boolean dead = false;
  boolean showInfo = true;
  boolean offScreen  = false;

  hero(String _name, float _hp, float _dmg, float _armor) {
    name = _name;
    hp = _hp;
    dmg = _dmg;
    armor = _armor;
    maxhp = hp;
  }

  void checkOnScreen() {
    if (x+r>-offsetX && x-r<-offsetX+width && y+r > -offsetY && y-r < -offsetY+height)
      offScreen = false;
    else offScreen = true;
  }

  void update() {
    checkOnScreen();
    t+=elapsedTime;
    if (hp<=0) {
      println(name+" погибает!");
      dead = true;
    }
    if (!events.isEmpty()) {
      if (!events.get(0).completed) {
        if (!events.get(0).isStarted) {
          events.get(0).Start(); 
          events.get(0).isStarted = true;
        }
        events.get(0).Update();
      } else {
        events.remove(events.get(0));
      }
    }

    for (hero trg : heroes) {
      if (this == trg) continue;
      if (dist(x, y, trg.x, trg.y)<r+trg.r) {
        float distance = dist(x, y, trg.x, trg.y);
        float overlap = 0.5 * (distance - r - trg.r);
        x -= overlap * (x - trg.x) / distance;
        y -= overlap * (y - trg.y) / distance;
      }
    }
  }

  void show() {
    if (!offScreen) {
      //strokeWeight(2);
      color c = (this == selected) ? color(255,0,0) : 0;
      stroke(c);
      fill(255);
      ellipse(x, y, r*2, r*2);
      line(x,y,cos(a)*r+x,sin(a)*r+y);
      text(name, x+10, y+15);
      if (this == selected) {
        noFill();
        ellipse(x,y,attackRange*2,attackRange*2);
        fill(255);
        text("HP: "+hp, x+10, y+15*2);
        text("DMG: "+dmg, x+10, y+15*3);
        text("ARMOR: "+armor+"%", x+10, y+15*4);
        text("SPEED: "+maxspeed,x+10,y+15*5);
      }
      noStroke();
      fill(70);
      rect(x-26,y-20,x+26,y-10);
      fill(0,255,0);
      rect(x-25,y-18,map(hp,0,maxhp,x-25,x+25),y-12);
    }
  }

  void attack(hero enemy) {
    hit = (100-enemy.armor) * dmg / 100;
    enemy.hp -= hit;
    println(name+" аттакует "+enemy.name+", нанося "+hit+"DMG!");
    t = 0;
  }
}
