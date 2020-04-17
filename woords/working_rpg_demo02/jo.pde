class jo extends event {
  void Start() {
    gameString = "";
    gameString += "Connecting to user...";
    //events.add(new wait(1.5, true));
    //events.add(new wait(0.5, false));
    //events.add(new wait(0.2, true));
    //events.add(new wait(1, false));
    //events.add(new wait(2, true));
    events.add(new jo1());
    completed = true;
    setButtons();
  }
}

class jo1 extends event {
  void Start() {
    gameString += "\nConnected! Say hi!";
    addChoice("Привет? Есть тут кто?");
    q = "...";
    setButtons();
  }
  void Update() {
    for (Button b : buttons) {
      if (b.isPressed) {
        events.add(new jo2());
        endChoice(b);
      }
    }
    showText();
  }
}

class jo2 extends event {
  void Start() {
    addChoice("Да");
    addChoice("Нет");
    addChoice("Я пришел по твою душу");
    joSays("Привет, "+playerName+"! Ты пришел пообщатся со мной?");
    setButtons();
  }

  void Update() {
    for (Button b : buttons) {
      if (b.isPressed) {
        if (b.id == 0) {
          respect+=2;
          events.add(new wait(0.5, false));
          events.add(new j2(false));
          endChoice(b);
        }
        if (b.id == 1) {
          respect-=1;
          events.add(new wait(3, false));
          events.add(new j2(false));
          endChoice(b);
        }
        if (b.id == 2) {
          respect-=2;
          events.add(new wait(2, false));
          events.add(new wait(5, true));
          events.add(new j2(true));
          endChoice(b);
        }
      }
    }
    showText();
  }
}

class j2 extends event {
  boolean f = false;
  j2(boolean funny) {
    f = funny;
  }
  void Start() {
    addChoice("Мальчик");
    addChoice("Девочка");
    if (f) { 
      joSays("Хах, это смешно :) \n");
      popups.add(new popup("FUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOUFUCKYOU",0.5,1));
      popups.add(new popup("Эй, ты что, пытаешься её разозлить? Будь по-мягче иначе все пойдет коту под хвост.",10, 0));
    }
    joSays("Тогда давай общатся да? Начнем вот с чего: ты мальчик или девочка?");
    setButtons();
  }
  void Update() {
    for(Button b : buttons){
      if(b.isPressed){
        if(b.id == 0){
          respect+=1;
          events.add(new wait(1,false));
          events.add(new j2a1());
          endChoice(b);
        }
        if(b.id == 1){
          respect-=1;
          events.add(new wait(2,false));
          events.add(new j2a2());
          endChoice(b);
        }
      }
    }
    showText();
  }
}

class j2a1 extends event{
  void Start(){
    addChoice("Это хорошо или плохо?..");
    addChoice("Я никогда не вру.");
    addChoice("Кто знает...");
    if(respect<0){
      joSays("Ну, ты хотя бы не склонен ко вранью...");
    }else joSays("Приятно знать что ты не врун :)");
    setButtons();
  }
  void Update(){
    for(Button b : buttons){
       if(b.isPressed){
         if(b.id == 0){
           events.add(new wait(1, false));
           events.add(new j3());
           endChoice(b);
         }
         if(b.id == 1){
           events.add(new wait(1, false));
           events.add(new j3());
           respect-=1;
           endChoice(b);
         }
         if(b.id == 2){
           events.add(new wait(1, false));
           events.add(new j3());
           respect+=1;
           endChoice(b);
         }
       }
    }
    showText();
  }
}

class j2a2 extends event{
  void Start(){
    addChoice("Прости...");
    if(respect < 0){
      respect-=1;
      joSays("Слушай, не беси меня. Это был вопрос с подвохом, я знаю что ты мужчина."); 
    }else joSays("Хах, ну ты смешной :) Это был вопрос с подвохом! Я знаю что ты мальчик.");
    setButtons();
  }
  void Update(){
    for(Button b : buttons){
      if(b.isPressed){
        events.add(new wait(1, false));
        events.add(new j3());
        endChoice(b);
      }
    }
    showText();
  }
}

class j3 extends event{
  void Start(){
    addChoice("Я никогда бы не поддался соблазну подобного");
    addChoice("Нет");
    addChoice("Да");
    joSays("Ответь на вопрос, ты когда нибудь хотел что-нибудь настолько сильно, что ты бы мог отдать свою человечность за это?");
    popups.add(new popup("Выбирай свои слова с предельной аккуратностью начиная отсюда. (ЗДЕСЬ КСТАТИ КОНЕЦ ДЕМКИ ЛОЛ. ТВОЙ УРОВЕНЬ СТАБИЛЬНОСТИ ЧАТА: "+respect+". МОЛОДЕЦ)",10,2));
    setButtons();
  }
  void Update(){
    for(Button b : buttons){
      if(b.isPressed){
        if(b.id == 0){
          respect-=10;
          events.add(new wait(13,true));
          popups.add(new popup("Молодец.",4,1));
          events.add(new j3angry());
          endChoice(b);
        }
      }
    }
    showText();
  }
}

class j3angry extends event{
  void Start(){
    addChoice("Нет");
    addChoice("Да");
    joSays("Ты пытаешься намекнуть насколько я жалкое существо?");
    popups.add(new popup("Даже не думай писать нет.",10,0.5));
    setButtons();
  }
  
  void Update(){
    
    showText();
  }
}
