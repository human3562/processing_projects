float moveBorder = 100;
float camSpeed = 10;
float scl = 1;
boolean up, down, left, right;
boolean cmdType = false;
String command = "";
void mousePos() {
  //if (mouseX>width-moveBorder) offsetX+=camSpeed;
  //if (mouseX<moveBorder) offsetX-=camSpeed;
  //if (mouseY>height-moveBorder) offsetY+=camSpeed;
  //if (mouseY<moveBorder) offsetY-=camSpeed;
  if (left) offsetX -= camSpeed;
  if (right) offsetX += camSpeed;
  if (up) offsetY -= camSpeed;
  if (down) offsetY += camSpeed;
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    if (cmdType) {
      
      if(command.contains("moveBot")){ //moveBot 0 10 23
        String op = command.substring(9);
        int idP = 0;
        int mX = 0;
        int mY = 0;
        
        for(int i = 0; i<op.length(); i++)
          if(op.charAt(i) == ' '){
             idP = (int(op.substring(0,i)));
             op = op.substring(i+1);
             break;
          }
        for(int i = 0; i<op.length(); i++){
          if(op.charAt(i) == ' '){
            mX = int(op.substring(0,i));
            mY = int(op.substring(i+1));
            break;
          }
        }
        
       if(bots.get(idP) != null && idP < bots.size()){
         bots.get(idP).commands.add(new moveTo(mX, mY)); 
       }
      }
      
      if(command.contains("getProd")){ // getProd 0 dummy 5
        String op = command.substring(9);
        int idP = 0;
        String name = "";
        int amt = 0;
        for(int i = 0; i<op.length(); i++)
          if(op.charAt(i) == ' '){
             idP = (int(op.substring(0,i)));
             op = op.substring(i+1);
             break;
          }
        for(int i = 0; i<op.length(); i++){
          if(op.charAt(i) == ' '){
            name = op.substring(0,i);
            amt = int(op.substring(i+1));
            break;
          }
        }
        println("you have requested "+name+". The bot with id "+idP+" is going to get "+amt+" of those for you.");
        if(bots.get(idP) != null && idP < bots.size()){
         bots.get(idP).getProduct(name,amt);
       }
      }
      
      cmdType = false;
      command = "";
    } else {
      cmdType = true;
    }
  }
  if (!cmdType) {
    if (keyCode == 'A' || keyCode == 'a') {
      left = true;
    }
    if (keyCode == 'D' || keyCode == 'd') {
      right = true;
    }
    if (keyCode == 'W' || keyCode == 'w') {
      up = true;
    }
    if (keyCode == 'S' || keyCode == 's') {
      down = true;
    }
  } else {
    if (key == BACKSPACE) {
      if (command.length()>0)
        command = command.substring(0, command.length()-1);
    } else if(key != RETURN && keyCode != SHIFT && key != TAB && key!=CONTROL)
      command += key;
  }
}

void keyReleased() {
  if (keyCode == 'A' || keyCode == 'a') {
    left = false;
  }
  if (keyCode == 'D' || keyCode == 'd') {
    right = false;
  }
  if (keyCode == 'W' || keyCode == 'w') {
    up = false;
  }
  if (keyCode == 'S' || keyCode == 's') {
    down = false;
  }
}

void mouseWheel(MouseEvent e){
  zoom-=(e.getCount())*0.1;
  if(zoom < 0.5) zoom = 0.5;
  if(zoom > 6) zoom = 6;
}
