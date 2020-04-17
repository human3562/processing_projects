
ArrayList<cutscene> cutscenes = new ArrayList<cutscene>();

void godCutscene() {
  cutscene Cgod = new cutscene();
  Cgod.duration = 5;
  actor GOD = new actor();
  GOD.texture = images.god;
  Cgod.involvedActors.add(GOD);
  cutscenes.add(Cgod);
} 

class cutscene {
  float duration;
  float t;
  ArrayList<actor> involvedActors= new ArrayList<actor>();
  boolean finished = false;
  boolean started = false;
  void Start() {
    //Player.yPosition = 0; 
    println("ass");
    started = true;
  }
  void update() {
    if (t<duration) {
      Player.yspeed = (200 - Player.yPosition) * elapsedTime * 150;
      
      for (actor a : involvedActors) {
        if (t<=duration/2) {
          a.a += map(t,0,duration/2,-0.0055*150,0) * elapsedTime;
        }else if(t>duration/2+duration*0.25){
          a.a -= map(t,0,duration/2+duration*0.25,0.02*150,0) * elapsedTime;
        }
        a.x = Player.xPosition;
        a.y = 0;
        a.show();
      }
      t+=elapsedTime;
    } else finished = true;
  }
}

class actor {
  PImage texture;
  float x = 0;
  float y = 0;
  float ox = 0;
  float oy = 0;
  float a = 0;
  void show() {
    pushMatrix();
    imageMode(CENTER);
    translate(x+texture.width, y-125);
    rotate(a);
    translate(-texture.width/2, -texture.height/2);
    image(texture, 0, 0);
    popMatrix();
  }
}

void removeCutscenes() {
  for (int i = cutscenes.size() - 1; i >= 0; i--) {
    cutscene part = cutscenes.get(i);
    if (part.finished) {
      cutscenes.remove(i);
    }
  }
}
