void keyPressed(){
  if(keyCode == 'w'|| keyCode == 'W'){
    p.up = true; 
  }
  if(keyCode == 's'|| keyCode == 'S'){
    p.down = true; 
  }
  if(keyCode == 'a'|| keyCode == 'A'){
    p.left = true; 
  }
  if(keyCode == 'd'|| keyCode == 'D'){
    p.right = true; 
  }
}
void keyReleased(){
  if(keyCode == 'w'|| keyCode == 'W'){
    p.up = false; 
  }
  if(keyCode == 's'|| keyCode == 'S'){
    p.down = false; 
  }
  if(keyCode == 'a'|| keyCode == 'A'){
    p.left = false; 
  }
  if(keyCode == 'd'|| keyCode == 'D'){
    p.right = false; 
  }
}
