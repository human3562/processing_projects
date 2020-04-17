void keyPressed(){
  if(key == '.' || key == '-' || key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9'){
    if(select == 0){
      sA += key; 
    }else if(select == 1){
      sB += key;
    }else if(select == 2){
      sC += key; 
    }
  }
  if(key == BACKSPACE){
    if(select == 0){
      if(!sA.isEmpty())
      sA = sA.substring(0, sA.length()-1); 
    }else if(select == 1){
      if(!sB.isEmpty())
      sB = sB.substring(0, sB.length()-1); 
    }else if(select == 2){
      if(!sC.isEmpty())
      sC = sC.substring(0, sC.length()-1); 
    }
  }
}

void mousePressed(){
   if(mOver(80, 135, width-20, 180)){
     select = 0;
   }else if(mOver(80, 205, width-20, 250)){
     select = 1;
   }else if(mOver(80, 275, width-20, 320)){
     select = 2;
   }else select = -1;
}

boolean mOver(float x1, float y1, float x2, float y2){
  return(mouseX>x1 && mouseX < x2 && mouseY>y1 && mouseY<y2);
}
