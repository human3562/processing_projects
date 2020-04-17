void keyPressed() {
  if (key == ESC){
    key = 0;
    client.write("announce "+name+" вышел.\n");
    delay(1000);
    exit();
    return;
  }
  if (key == BACKSPACE) {
    if (typing.length()>0)
      typing = typing.substring(0, typing.length()-1);
  } else if ((keyCode != ENTER && keyCode != RETURN && keyCode != SHIFT && key != TAB && keyCode!=CONTROL && keyCode!=ALT) && typing.length()<600) {
    typing += key;
  }
  if((keyCode == ENTER || keyCode == RETURN) && typing.length()>0){
    if(state == "SETUP"){
      name = typing;
      typing = "";
      state = "CHAT";
      client.write("announce "+name+" вошел в чат.\n");
    }else if(state == "CHAT"){
      String msg = "";
      msg = name.trim()+" says "+typing;
      typing = "";
      client.write(msg+"\n");
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  scroll+=e*8;
}
