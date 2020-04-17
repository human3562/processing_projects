ArrayList<character> characters = new ArrayList<character>();
int selectedA = 0;
int talkto = -1;
class character {
  controller control;
  ArrayList<popup> popups = new ArrayList<popup>();
  float xPosition;
  float yPosition;
  float xspeed;
  float yspeed;
  //ArrayList<Iitem> items = new ArrayList<Iitem>();
  ArrayList<q> questions = new ArrayList<q>();
  int currentQ = 0;
  int id;
  String Name = "";
  PImage charArt;
  PImage charTexture;
  boolean gone = false;
  private float ti = 0;
  private boolean showArt = false;
  private boolean dialogueEnd = false;
  boolean onGround;
  boolean onLadder;
  boolean up, down, left, right;
  float w = 64;
  float h = 64;
  float hp = 100;
  float maxHp = 100;
  float maxSpeed = 500;
  float acc = 6500;
  boolean isDead = false;
  boolean canMove = true;
  int respect = 0;
  boolean fight = false;

  //character(float X, float Y) {
  //  xPosition = X;
  //  yPosition = Y;
  //  id = characters.size();
  //}
  character(){
    control = new controller(this); 
  }

  void update() {
    if (charArt!=null) {
      if (showArt) {
        gone = false;
        if (ti<2)
          ti+=10*1/frameRate*map(ti, 0, 2, 1, 0.01);
      } else {
        if (ti>0)
          ti-=10*1/frameRate*map(ti, 0, 2, 1, 0.01);
        else
          gone=true;
      }
      //println(showArt);
      image(charArt, map(ti, 0, 2, width/2, 0), 0, width+map(ti, 0, 2, width/2, 0), height);
    }
    if (!questions.isEmpty()) {
      timestep = 0;
      Player.canMove = false;
      //println("trynashow");
      fill(255);
      textSize(24);
      textAlign(LEFT);
      text(Name, 10, 50);
      text(questions.get(currentQ).text, 10+(width-10)/2, 75+height/2, width-10, height);
      if (questions.get(currentQ).answers!=null) {
        for (int i = 0; i<questions.get(currentQ).answers.size(); i++) {
          int o = ((selectedA==i)?15:0);
          text(questions.get(currentQ).answers.get(i).text, 25+o, height-questions.get(currentQ).answers.size()*25+25*i);
        }
      }
      textSize(12);
    }
    if(respect < -100){
      fight = true;
    }
    if (gone == true && dialogueEnd == true) {
      //print("assss");
      talkto = -1;
      targetFade = 0;
    }
  }

  void takeDamage(float dmg) {
    popups.add(new popup(xPosition, yPosition, dmg, false)); 
    boom(xPosition, yPosition, int(dmg), color(255, 0, 0)); 
    //hp-=dmg; 
    if (hp<0) hp = 0;
  }

  void specialTrait() {
  }

  void show() {
    control.Update();
    if (hp<=0)
      isDead = true;
    else isDead = false;
    if (isDead) canMove = false;
    else canMove = true;
    specialTrait();
    //this will also act as an npc update function
    yspeed+=2000*elapsedTime;
    if (canMove) {
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
      if (abs(xspeed)>0 && (!left && !right) || canMove == false) {
        xspeed += map(xspeed, -maxSpeed, maxSpeed, acc, -acc)*elapsedTime;
      }
      //xspeed += -8 * xspeed * elapsedTime;
      if (abs(xspeed) < 0.1f)
        xspeed = 0.0f;
    }

    if (xspeed>5000) xspeed = 5000;
    if (xspeed<-5000) xspeed = -5000;
    if (yspeed>5000) yspeed = 5000;
    if (yspeed<-5000) yspeed = -5000;
    float newxPosition = xPosition + xspeed * elapsedTime;
    float newyPosition = yPosition + yspeed * elapsedTime;



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


    fill(0, 0, 255);
    noStroke();
    rectMode(CENTER);
    image(images.drinkmachine,xPosition, yPosition);

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

  void checkAnswerLog() {
  }

  void showChar() {
    showArt = true;
  }

  void hideChar() {
    showArt = false;
  }

  void endDialogue() {
    hideChar(); 
    Player.canMove = true;
    dialogueEnd = true;
  }

  void say() {
    q Q = questions.get(currentQ);
    if (!Q.dEnd) {
      Q.action();
      currentQ = Q.next;
    } else
      endDialogue();
  }
}

class q {
  int id;
  String text = "";
  int next;
  ArrayList<a> answers = new ArrayList<a>();
  int answeredId = -1;
  boolean dEnd = false;
  q(String t, int ID, ArrayList<a> as, boolean isEnd) {
    id = ID;
    text = t;
    answers = as;
    dEnd = isEnd;
  }
  void action() {
    if (answers!=null) {
      next = answers.get(selectedA).next;
      answeredId = selectedA;
      selectedA = 0;
    }
  }
}

class a {
  int id;
  String text = "";
  int next;
  a(String t, int ID, int Next) {
    text = t;
    id = ID;
    next = Next;
  }
}
