class menu extends event{
  void Start(){
    addChoice("Выход");
    addChoice("Настройки");
    addChoice("Начать игру");
    setMenuButtons();
  }
  void Update(){
    for(Button b : buttons){
      if(b.isPressed){
        if(b.id == 0){
          exit();
        }
        if(b.id == 1){
          println("ay fuck off this doesn't work yet");
          b.isPressed = false;
        }
        if(b.id == 2){
          GameState = 1;
          completed = true;
          return;
        }
      }
    }
    showText();
  }
}

class options extends event{
  void Start(){
     
  }
  void Update(){
    
  }
}
