class character {
  ArrayList<Item> items = new ArrayList<Item>();
  ArrayList<q> questions = new ArrayList<q>();
  int currentQ = 0;
  String Name = "";
  PImage charArt;
  private float t = 0;
  private boolean showArt = false;

  void update() {
    if (charArt!=null) {
      if (showArt) { 
        if (t<2)
          t+=10*elapsedTime*map(t, 0, 2, 1, 0.01);
      } else {
        if (t>0)
          t-=10*elapsedTime*map(t, 0, 2, 1, 0.01);
      }
      image(charArt, map(t, 0, 2, width/2, 0), 0, width+map(t, 0, 2, width/2, 0), height);
    }
    if (!questions.isEmpty()) {
      text(Name, 10, 50);
      text(questions.get(currentQ).text, 10, 75, width, height);
      if (questions.get(currentQ).answers!=null) {
        for (int i = 0; i<questions.get(currentQ).answers.size(); i++) {
          int o = ((selectedA==i)?15:0);
          text(questions.get(currentQ).answers.get(i).text, 25+o, height-questions.get(currentQ).answers.size()*25+25*i);
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

  void say() {
    q Q = questions.get(currentQ);
    Q.action();
    currentQ = Q.next;
  }
}

class q {
  int id;
  String text = "";
  int next;
  ArrayList<a> answers = new ArrayList<a>();
  int answeredId = -1;
  q(String t, int ID, ArrayList<a> as) {
    id = ID;
    text = t;
    answers = as;
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

class Fish extends character {
  boolean a1 = false;
  boolean a2 = false;
  void checkAnswerLog() {
    if ((super.questions.get(2).answeredId == 1 || super.questions.get(2).answeredId == 2 || super.questions.get(3).answeredId == 0 || super.questions.get(4).answeredId == 0) && a1 == false) {
      super.showArt = false;
      a1 = true;
    }
    if((super.questions.get(3).answeredId == 1 || super.questions.get(10).answeredId == 0) && a2 == false){
      Gold -= 10; 
      a2 = true;
    }
  }
}
