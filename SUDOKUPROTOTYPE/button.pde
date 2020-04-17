class button {
  float x, y;
  float w = 60;
  boolean isPressed;
  int id;
  
  boolean isMouseOver() {
    return(mouseX>x-w/2&&mouseX<x+w/2&&mouseY>y-w/2&&mouseY<y+w/2);
  }
  
  button(int _text){
    id = _text;
  }
  
  void show(){
    fill((isMouseOver()?200:255));
    stroke(0);
    strokeWeight((isPressed?2:1));
    rect(x,y,w,w);
    fill(0);
    textSize(40);
    text(id,x,y);
  }
  
}
