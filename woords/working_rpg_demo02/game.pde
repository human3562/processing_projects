void setGame() {
  menuEvents.add(new menu());
  events.add(new q1());
  //event ass = new event();
  
}


class q1 extends event {
  void Start() {
    addChoice("Нет, я не готов");
    addChoice("Да, начнем.");
    q = "-Ты готов?";
    setButtons();
  }

  void Update() {

    for (Button b : buttons) {
      if (b.isPressed) {
        if (b.id == 0) {
          events.add(new wait(0.2, false));
          events.add(new q1a2());
          endChoice(b);
        }
        if (b.id == 1) {
          events.add(new wait(0.2, false));
          events.add(new q1a1());
          endChoice(b);
        }
      }
    }
    showText();
  }
}

class q1a1 extends event {
  void Start() {
    addChoice("Продолжить...");
    q = "-Отлично. Сейчас ты попадешь в чат. Я буду присылать тебе сообщения время от времени чтобы направить тебя куда надо. Постарайся не провоцировать её, хорошо?";
    setButtons();
  }
  void Update() {
    for (Button b : buttons) {
      if (b.isPressed) {
        gameString = "";
        events.add(new wait(2, true));
        events.add(new transition());
        completed = true;
        return;
      }
    }
    showText();
  }
}

class q1a2 extends event {
  void Start() {
    addChoice("Хорошо...");
    q = "-Возвращайся когда будешь более уверенным в себе.";
    setButtons();
  }
  void Update() {

    for (Button b : buttons) {
      if (b.isPressed) {
        exit();
      }
    }

    showText();
  }
}



class transition extends event {
  void Start() {
    trygetname = true;
    gameString = "";
    addChoice("Продолжить с этим именем...");
    q = "-Выбери себе имя.";
    setButtons();
  }
  void Update() {
    for (Button b : buttons) {
      if (playerName.length()==0) {
        b.isActive = false;
      } else b.isActive = true;
      if (b.isPressed && playerName.length()>0) {
        trygetname = false;
        events.add(new confirmtransition());
        completed = true;
        return;
      }
    }
    fill(255);
    text("Меня зовут: " + playerName, width/2+5, Ystring+50);
    showText();
  }
}

class confirmtransition extends event {
  void Start() {
    gameString = "";
    addChoice("Я хочу перевыбрать свое имя.");
    addChoice("Я уверен что хочу использовать это имя.");
    q = "-Вы точно хотите продолжить с именем "+playerName+"?";
    setButtons();
  }
  void Update() {
    for (Button b : buttons) {
      if (b.isPressed) {
        if (b.id == 0) {
          events.add(new transition());
          completed = true;
          return;
        }
        if (b.id == 1) {
          events.add(new jo());
          completed = true;
          return;
        }
      }
    }
    showText();
  }
}
