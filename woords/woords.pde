settingsA setupSettings;
String[] text;
float elapsedTime = 0;
String typedString = "";
String gameState = "MENU";
int wordAmt = 0;
int charAmt = 0;
int typedWords = 0;
float time = 0;
int mistakes = 0;
int amt = 10;
float playTime = 0;

void setup() {
  size(1200, 600); 
  //randomSeed(0);
  //fullScreen();
  rectMode(CENTER);
  text = loadStrings("zdb-win8.txt");
  for (int j = 0; j < text.length; j++) {
    String s = text[j];
    int to = 0;
    for (int i = 0; i<s.length(); i++) {
      if (s.charAt(i) == ' ') {
        to = i;
      }
    }
    s = s.substring(to+1);
    text[j] = s;
  }
  println(text.length + " words loaded!");
  words.add(new word("начать!"));
  for (int i = 0; i<amt; i++)
    words.add(new word(text[(int)random(text.length)]));
  wordAmt = words.size();

  menuButtons = new settingsA();
  menuButtons.settings.add(new button("Начать", width/2, 205, 400, 70));
  menuButtons.settings.add(new button("Выход", width/2, 335, 350, 65));

  setupSettings = new settingsA();
  setupSettings.settings.add(new bool("Сброс при ошибке", 10, 20, false));
  setupSettings.settings.add(new bool("Авто-ввод", 10, 50, false));
  setupSettings.settings.add(new bool("Прогрессивная тряска слов", 10, 80, false));
  setupSettings.settings.add(new slider("Кол-во слов", 10, 110, 1, 200, 50));
  setupSettings.settings.add(new button("Продолжить", 130, height-50, 250, 50));
}

void draw() {
  elapsedTime = 1/frameRate;

  switch(gameState) {
  case "GAME": 
    mainGame();
    break;
  case "MENU": 
    menu();
    break;
  case "SETUP" : 
    gameSetting();
    break;
  case "STATS": 
    stats();
    break;
  }
  playTime += elapsedTime;
}
