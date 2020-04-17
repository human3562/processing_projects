ArrayList<event> events = new ArrayList<event>();
ArrayList<event> menuEvents = new ArrayList<event>();
ArrayList<popup> popups = new ArrayList<popup>();
int GameState = 0;
int respect = 0;
String gameString = "";
float Ystring = 0;
boolean trygetname = false;
String playerName = "";
PImage load;
PFont myFont;
float deltaTime;
void setup() {
  size(600, 300);
  //fullScreen();
  smooth(12);
  load = loadImage("loading.png");
  frameRate(60);
  //String[] fontList = PFont.list();
  //printArray(fontList);
  myFont = createFont("DINCondensedC", 32);
  textFont(myFont);
  imageMode(CENTER);
  textAlign(LEFT);
  textLeading(10);
  setGame();
}

void draw() {
  deltaTime = 1/frameRate;
  background(50);
  if (GameState==1) {
    textAlign(LEFT);
    textSize(17);
    fill(255);
    text(gameString, width/2+5, Ystring, width/2-20, height*3);
    textAlign(LEFT, TOP);
    if (minute()<10)
      text(hour()+":0"+minute(), 10, 10);
    else text(hour()+":"+minute(), 10, 10);
    //text(respect, 10, 10);
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
  }

  if (GameState == 0) {
    if (!menuEvents.isEmpty()) {
      if (!menuEvents.get(0).completed) {
        if (!menuEvents.get(0).isStarted) {
          menuEvents.get(0).Start(); 
          menuEvents.get(0).isStarted = true;
        }
        menuEvents.get(0).Update();
      } else {
        menuEvents.remove(events.get(0));
      }
    }
  }

  text(frameRate, 10, 40);

  for (int i = popups.size() - 1; i >= 0; i--) {
    popup part = popups.get(i);
    if (part.completed) {
      popups.remove(i);
    }
  }

    if (!popups.isEmpty()) {
      if (!popups.get(0).completed) {
        if (!popups.get(0).isStarted) {
          popups.get(0).Start(); 
          popups.get(0).isStarted = true;
        }
        popups.get(0).update();
      } else {
        popups.remove(events.get(0));
      }
    }

  //if (!popups.isEmpty()) {
  //  for (popup p : popups) {
  //    p.update();
  //  }
  //}
  //if(popups.size()>1){
  //  popups.get(popups.size()-2).remove = true; 
  //}
}
