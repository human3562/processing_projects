void setFish(){
  ArrayList<q> Q = new ArrayList<q>();

  ArrayList<a> A0 = new ArrayList<a>();
  a a01 = new a("Ты кто?", 0, 1);
  A0.add(a01); 
  q q0 = new q("", 0, A0);
  Q.add(q0);
  
  ArrayList<a> A1 = new ArrayList<a>();
  a a11 = new a("Я гуляю.",0,2);
  a a12 = new a("Я ищу торгаша.",1,3);
  a a13 = new a("Я ищу артефакты.",2,4);
  A1.add(a11);
  A1.add(a12);
  A1.add(a13);
  q q1 = new q("Я рыба. Че те надо?",1,A1);
  
  ArrayList<a> A2 = new ArrayList<a>();
  a a21 = new a("Ну, я те щас буду лицо ломать!",0,5);
  a a22 = new a("А. Ну ок, я сваливаю",1,6);
  a a23 = new a("Акулы? Ну тогда я пошел ломать им лица",2,7);
  A2.add(a21);
  A2.add(a22);
  A2.add(a23);
  q q2 = new q("Шагай подальше типа ыыв. Тут акулы водятся ОЛОЛ",2,A2);
  q q5 = new q("Ломать лицо мне? Ну попробуй, черт! \n(НАЧАЛО БОЯ)",5,null);
  q q6 = new q("Счастливой дороги.",6,null);
  q q7 = new q("Ну ты идиот... Я те дам вот эту хрень да, а ты уже типо вали да? Удачи.\n(ВЫ ПОЛУЧИЛИ КАКОЙ-ТО МУСОР)",7,null);

  ArrayList<a> A3 = new ArrayList<a>();
  a a31 = new a("А у меня нет бабла окда?",0,8);
  a a32 = new a("Ну держи, рыбас, 10 золотых.",1,9);
  a a33 = new a("А куда ты вообще будешь сувать эти 10 золотых? Ты типо рыба...",2,10);
  A3.add(a31);
  A3.add(a32);
  A3.add(a33);
  q q3 = new q("Ну тут есть два торгаша, да. Один на севере, другой на юге, оба дето 2000км отсюда.. Ну тут еще есть один, но я типо голодный понимаешь? В общем гони 10 золотых и расскажу",3,A3);
  q q8 = new q("А. Ну досвидания тогда.",8,null);
  q q9 = new q("Опа! Ну чекай: торгаш тут вот за углом тупо его даже видно отсюда но спс за десяточку, че.",9,null);
  
  ArrayList<a> A4 = new ArrayList<a>();
  a a41 = new a("Ну ладно, ладно, держи  свои 10 золотых.",0,13);
  a a42 = new a("Ну держись рыба ты недоплавающая, щас буду лицо БИТЬ!",1,14);
  A4.add(a41);
  A4.add(a42);
  q q10 = new q("Слышишь философ ты недобитый, не умничай тут а? А то лицо как сломаю то вопросов уже не будет понял?",10,A4);
  q q13 = new q("Ну вот так вот лучше, ну чекай, лохан ты запутанный, вон торгаш стоит, его даже видно отсюда аутан ты недовыдержанный. А вот десяточка пойдет мне на пользу.",13,null);
  q q14 = new q("Ну давай давай, отмудохаю тебя так что ты в жизни даже на рыбу больше смотреть не сможешь, вегетарианцом аж станешь\n(НАЧАЛО БОЯ)",14,null);
  
  ArrayList<a> A5 = new ArrayList<a>();
  a a51 = new a("Ну вот сразу видно что ты говоришь ну чистую правду да, ну я тогда пошел. Спасибо.",0,11);
  a a52 = new a("А че такое? Ссыкотно А? НУ ИДИ ЩАС ЛИЦО БУДУ ЛОМАТЬ",1,12);
  A5.add(a51);
  A5.add(a52);
  q q4 = new q("А Я ТИПО НИЧЕ НЕ ЗНАЮ, ПОНЯЛ?",4,A5);
  q q11 = new q("Скатертью дорога",11,null);
  q q12 = new q("А ты щас сдохнешь лол \n(НАЧАЛО БОЯ)",12,null);
  
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
  fish.questions = Q;
  fish.Name = "РЫБА";
}