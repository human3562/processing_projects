class Command {
  boolean completed = false;
  boolean isStarted = false;

  void Start() {
  }
  void Update() {
  }
}

class moveTo extends Command {
  hero b;
  float trgX, trgY;
  float startX, startY;
  moveTo(hero Bot, float x, float y) {
    b = Bot;
    trgX = x;
    trgY = y;
  }
  void Start() {
    startX = b.x;
    startY = b.y;
  }
  void Update() {
    if (dist(b.x, b.y, trgX, trgY)<20) {
      completed = true;
    }

    pushMatrix();
    translate(b.x, b.y);
    stroke(255);
    line(0, 0, trgX - b.x, trgY - b.y);
    float a = atan2(trgY - b.y, trgX - b.x);
    b.a = a;
    b.x += cos(a) * b.maxspeed * elapsedTime;
    b.y += sin(a) * b.maxspeed * elapsedTime;
    //line(0, 0,cos(a)*50,sin(a)*50);
    //b.position.x += moveX;
    //b.position.y += moveY;
    popMatrix();
  }
}

class wait extends Command {
  float sec = 0;
  float time = 0;
  wait(float seconds) {
    sec = seconds;
  }

  void Update() {
    if (time>=sec) 
      completed = true;
    else
      time += 1/frameRate;
  }
}


class attack extends Command {
  ArrayList<Command> c = new ArrayList<Command>();
  hero me;
  hero target;
  boolean done = false;

  attack(hero _me, hero _target) {
    me = _me;
    target = _target;
  }

  void Start() {
    if (dist(me.x, me.y, target.x, target.y)<me.attackRange) {
      if (me.t>me.attackSpeed) {
        me.attack(target);
        if (!target.dead)
          me.events.add(new attack(me, target));
        completed = true;
      }
    } else {
      c.add(new moveTo(me, target.x, target.y));
    }
  }
  void Update() {
    if (!completed) {
      if (dist(me.x, me.y, target.x, target.y)<me.attackRange) {
        c.clear();
        if (me.t>me.attackSpeed) {
          me.attack(target);
          if (!target.dead)
            me.events.add(new attack(me, target));
          completed = true;
        }
      } else {
        c.clear();
        c.add(new moveTo(me, target.x, target.y));
      }
      if (!c.isEmpty()) {
        if (!c.get(0).completed) {
          if (!c.get(0).isStarted) {
            c.get(0).Start(); 
            c.get(0).isStarted = true;
          }
          c.get(0).Update();
        } else {
          c.remove(c.get(0));
        }
      }
    }
  }
}
