ArrayList<sBot> bots = new ArrayList<sBot>();
float botWidth = rW/2;
class sBot {
  ArrayList<cmd> commands = new ArrayList<cmd>();
  float positionX, positionY;
  //float speedX, speedY;
  object storageObj = null;
  int amt = 0;
  float maxSpeed = 200;
  int maxCapacity = 10;
  float takeSpeed = 2;
  color c = 0;
  int id;
  float energy = 100;
  float maxEnergy = 100;
  sBot(float idx, float idy, int _id) {
    positionX = rW/2 + idx * rW;
    positionY = rW/2 + idy * rW;
    id = _id;
  }

  void update() {
    if (!commands.isEmpty()) {
      switch(commands.get(0).getClass().toString().substring(18)) {
      case "moveTo":
        String info = commands.get(0).getInfo();
        float mx = 0, my = 0;
        for (int i = 0; i<info.length(); i++) {
          if (info.charAt(i) == ' ')
            mx = float(info.substring(0, i));
          my = float(info.substring(i));
        }
        stroke(0,200,0);
        strokeWeight(2);
        float gotoX = mx*rW+rW/2;
        float gotoY = my*rW+rW/2;
        if (abs(positionX-gotoX)<0.1) {
          positionX = gotoX;
          line(positionX,positionY,gotoX,gotoY);
          float sy = (gotoY - positionY)*5;
          sy = constrain(sy, -maxSpeed, maxSpeed);
          positionY += sy *elapsedTime;
        } else {
          line(positionX,positionY,gotoX,positionY);
          line(gotoX,positionY,gotoX,gotoY);
          float sx = (gotoX - positionX)*5;
          sx = constrain(sx, -maxSpeed, maxSpeed);
          positionX += sx *elapsedTime;
        }
        //line(positionX * 1/scl, positionY * 1/scl, gotoX * 1/scl, gotoY * 1/scl);
        if (abs(gotoX - positionX) < 0.5 && abs(gotoY - positionY) < 0.5) {
          positionX = gotoX;
          positionY = gotoY;
          energy-=5;
          commands.remove(commands.get(0));
        }
        break;

      case "take":
        if (!commands.get(0).started) commands.get(0).Start();
        String inf = commands.get(0).getInfo();
        int amt = 0;
        float t = 0;
        for (int i = 0; i<inf.length(); i++) {
          if (inf.charAt(i) == ' ') {
            amt = int(inf.substring(0, i));
            t = float(inf.substring(i));
            break;
          }
        }
        float time = amt/takeSpeed;
        float ti = globalTimer-t;
        c = color(ti/time * 255, 0, 0);
        if (ti>time) {
          energy-=1;
          commands.remove(commands.get(0));
        }
        break;

      default: 
        println(commands.get(0).getClass().toString().substring(18));
        break;
      }
    }
  }

  void getProduct(String name, int amt) {
    for (sCell o : storageGrid) {
      if (o.storageObj == null) continue;
      else if (o.storageObj.name.contains(name)) {
        commands.add(new moveTo(o.idX, o.idY));
        commands.add(new take(amt));
        break;
      }
    }
  }

  void show() {
    rectMode(CENTER);
    fill(c);
    strokeWeight(1);
    stroke(0);
    rect(positionX, positionY, botWidth, botWidth);
    //NRG
    strokeCap(SQUARE);
    strokeWeight(4);
    stroke(100);
    line(positionX+botWidth/2-4,positionY-botWidth/2+2,positionX+botWidth/2-4,positionY+botWidth/2-2);
    stroke(0,0,255);
    strokeCap(SQUARE);
    strokeWeight(4);
    line(positionX+botWidth/2-4,(positionY+botWidth/2-2)-map(energy,0,maxEnergy,0,2*(botWidth/2-2)),positionX+botWidth/2-4,positionY+botWidth/2-2);
    fill(255);
    textSize(4);
    textAlign(LEFT,TOP);
    text("NRG",positionX,positionY-botWidth/2+2);
    //CAP
    text("CAP",positionX-botWidth/2+4,positionY+botWidth/2-6);
    
    textAlign(CENTER,CENTER);
    textSize(6);
    text("ID:"+id,positionX,positionY);
  }
}

class cmd {
  int batamt; 
  boolean finished = false;
  boolean started = false;

  void Start() {
    started = true;
  }

  String getInfo() {

    return "";
  }
}

class moveTo extends cmd {
  int x, y;
  moveTo(int cX, int cY) {
    x = cX;
    y = cY;
    batamt = 1;
  }

  String getInfo() {
    return (x+" "+y);
  }
}

class take extends cmd {
  int amt;
  float t = 0;
  take(int a) {
    amt = a;
  }
  String getInfo() {
    return amt+" "+t;
  }
  void Start() {
    started = true;
    t = globalTimer;
  }
}
