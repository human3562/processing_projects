class event {
  ArrayList<Button> buttons = new ArrayList<Button>();
  String q = "";
  boolean completed = false;
  boolean isStarted = false;

  void setButtons() {
    if (q!="") {
      gameString += "\n"+q;
    }
    if (!buttons.isEmpty()) {
      for (int i = 0; i<buttons.size(); i++) {
        Button b = buttons.get(i);
        b.x = 10;
        b.h = (20 + 65 * map(b.text.length(), 0, 100, 0, 1)) + 4;
        b.y = (i == 0)? height - b.h - 10 : buttons.get(i-1).y - b.h - 10;
        b.w = width/2 - b.x*2;
        //print(map(b.text.length(), 0, 100, 0, 1)+" ");
      }
    }
    
    
  }
  
  void setMenuButtons(){
     for (int i = 0; i<buttons.size(); i++) {
        Button b = buttons.get(i);
        b.x = width/4;
        b.y = (i == 0)? height - b.h - 40 : buttons.get(i-1).y - b.h - 40;
        b.w = width/2 ;
        b.h = (20 + 25 * map(b.text.length(), 0, 100, 0, 1)) + 4;
        //print(map(b.text.length(), 0, 100, 0, 1)+" ");
      }
  }

  void joSays(String says){
    q += "\njo: "+says;
  }

  void addChoice(String text) {
    buttons.add(new Button(buttons.size(), text));
  }

  void showText() {
    checkButtons();
    textSize(13);
    fill(255);
  }

  void endChoice(Button b) {
    gameString += "\n  -" + b.text;
    completed = true;
    return;
  }

  void checkButtons() {
    if (!buttons.isEmpty()) {
      for (Button b : buttons) {
        b.update();
      }
    }
  }

  void Start() {
    for (Button b : buttons) {
      b.isPressed = false;
    }
  }
  void Update() {
  }
}
