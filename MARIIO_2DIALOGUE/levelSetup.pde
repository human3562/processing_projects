//ALSO CHARACTER SETUP!
JSONObject level1;
JSONObject level2;
void setLevels() {
  level1 = loadJSONObject("testingMap1.json");
  level2 = loadJSONObject("testgoto2.json");

  level l1 = new level();
  JSONObject level = new JSONObject();
  level.setInt("levelWidth", level1.getInt("levelWidth"));
  level.setInt("levelHeight", level1.getInt("levelHeight"));
  level.setInt("levelId", level1.getInt("levelId"));
  JSONArray levelblocks = level1.getJSONArray("blocks");
  l1.setLevel(level, levelblocks);
  levels.add(l1);

  level l2 = new level();
  JSONObject _level = new JSONObject();
  _level.setInt("levelWidth", level2.getInt("levelWidth"));
  _level.setInt("levelHeight", level2.getInt("levelHeight"));
  _level.setInt("levelId", level2.getInt("levelId"));
  JSONArray _levelblocks = level2.getJSONArray("blocks");
  l2.setLevel(_level, _levelblocks);
  levels.add(l2);
}

void setFish() {
  Fish fish = new Fish();
  ArrayList<q> Q = new ArrayList<q>();

  ArrayList<a> A0 = new ArrayList<a>();
  a a01 = new a("Ты кто?", 0, 1);
  A0.add(a01); 
  q q0 = new q("", 0, A0, false);
  Q.add(q0);

  ArrayList<a> A1 = new ArrayList<a>();
  a a11 = new a("Я гуляю.", 0, 2);
  a a12 = new a("Я ищу торгаша.", 1, 3);
  a a13 = new a("Я ищу артефакты.", 2, 4);
  A1.add(a11);
  A1.add(a12);
  A1.add(a13);
  q q1 = new q("I am a fish. What do you need?", 1, A1, false);

  ArrayList<a> A2 = new ArrayList<a>();
  a a21 = new a("I am going to break your face.", 0, 5);
  a a22 = new a("Oh, ok. I'll go away then.", 1, 6);
  a a23 = new a("Sharks? I'm going to break their face.", 2, 7);
  A2.add(a21);
  A2.add(a22);
  A2.add(a23);
  q q2 = new q("There are sharks around here, you better get out.", 2, A2, false);
  q q5 = new q("Break my face? I'd like to see you try! \n(BATTLE START)", 5, null, true);
  q q6 = new q("Seeya weirdo.", 6, null, true);
  q q7 = new q("Good luck to you... Tell you what, i'll give you this, and you can get out of my sight. Good luck.\n(YOU RECIEVED SOME SORT OF TRASH)", 7, null, true);

  ArrayList<a> A3 = new ArrayList<a>();
  a a31 = new a("I don't have any gold.", 0, 8);
  a a32 = new a("Ok, i will give you the gold.", 1, 9);
  a a33 = new a("Where are you going to put all this gold? I mean, you're a fish...", 2, 10);
  A3.add(a31);
  A3.add(a32);
  A3.add(a33);
  q q3 = new q("Well there are like two shops around here, one to the west and the other to the south, both are like 2000km away. There is one shop nearby though, but i'm hungry, you know what i mean? Just give me 10 gold and i'll tell you.", 3, A3, false);
  q q8 = new q("Oh, well then seeya later.", 8, null,true);
  q q9 = new q("Great! Well, check this out, there's a shop like right there, i mean, you can even see it from here. Thanks for the gold though!", 9, null, true);

  ArrayList<a> A4 = new ArrayList<a>();
  a a41 = new a("Ok ok, fishman, take the gold.", 0, 13);
  a a42 = new a("Ok then, i am going to break you!", 1, 14);
  A4.add(a41);
  A4.add(a42);
  q q10 = new q("What are you, a philosopher? Give me the gold or get out before i slap you with my tail.", 10, A4,false);
  q q13 = new q("Oh wow. Alright, check this out you weird dog, there is the shop. You can literally see it from here, but the money will come in handy for me tho.", 13, null, true);
  q q14 = new q("Well get to it then! I'll hit you so hard you gonna go vegetarian!\n(BATTLE START)", 14, null, true);

  ArrayList<a> A5 = new ArrayList<a>();
  a a51 = new a("Well i can clearly see that you are obviously not lying, so i'll be on my way.", 0, 11);
  a a52 = new a("What's that? Are you scared? Well come here and let me break your face!", 1, 12);
  A5.add(a51);
  A5.add(a52);
  q q4 = new q("I DON'T KNOW NOTHIN', OK?", 4, A5, false);
  q q11 = new q("Yeah, get outta here!", 11, null, true);
  q q12 = new q("Oh snap, you gon' die. \n(BATTLE START)", 12, null, true);

  Q.add(q1);
  Q.add(q2);
  Q.add(q3);
  Q.add(q4);
  Q.add(q5);
  Q.add(q6);
  Q.add(q7);
  Q.add(q8);
  Q.add(q9);
  Q.add(q10);
  Q.add(q11);
  Q.add(q12);
  Q.add(q13);
  Q.add(q14);

  //q q1 = new q("Come on in boy, i've got everything you need.", 1, null);
  //q q2 = new q("I don't recognize your face, little one. Get lost.", 2, null);
  //q q3 = new q("How rude. You can leave now.", 3, null);

  //Q.add(q1); 
  //Q.add(q2); 
  //Q.add(q3);
  //imageMode(CORNER);
  fish.charArt = loadImage("textures/fishman.png");
  fish.questions = Q;
  fish.Name = "FISHBOI";
  fish.xPosition = 64*3;
  fish.yPosition = (levels.get(currentLevel).levelHeight-6)*64;
  fish.id = characters.size();
  characters.add(fish);
}

class Fish extends character {
  boolean a1 = false;
  boolean a2 = false;
  
  void specialTrait(){
    
  }
  
  void checkAnswerLog() {
    //if (super.questions.get(2).answeredId == 1 || super.questions.get(2).answeredId == 2 || super.questions.get(3).answeredId == 0 || super.questions.get(4).answeredId == 0 && a1 == false) {
    //  super.showArt = false;
    //  a1 = true;
    //}
    if (super.questions.get(3).answeredId == 1 || super.questions.get(10).answeredId == 0 && a2 == false) {
      //Gold -= 10; 
      a2 = true;
    }
  }
}
