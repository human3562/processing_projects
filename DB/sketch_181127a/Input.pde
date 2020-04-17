ArrayList<inputField> inputs = new ArrayList<inputField>();
class inputField {
  float x, y, w, h;
  String text = "";
  boolean selected = false;
  inputField(float _x, float _y, float _w, float _h){
    x = _x; y = _y; w = _w; h = _h;
  }
  void show(){
    textAlign(LEFT);
    rectMode(CENTER);
    strokeWeight(1);
    stroke(selected?color(255,0,0):0);
    fill(255);
    rect(x,y,w,h);
    fill(0);
    text(text,x,y,w-2,h);
  }
  void listen(char k) {
    if (selected) {
      if (k == BACKSPACE) {
        if (text.length()>0) {
          text = text.substring(0, text.length()-1);
        }
      } else if(key == ENTER || key == RETURN){
        selected = false;
      }else{
        text+=k;
      }
    }
  }
  boolean mouseOver(){
    if(mouseX>=x-w/2 && mouseX<=x+w/2 && mouseY>=y-h/2 && mouseY<=y+h/2){
      return true;
    }else return false;
  }
}

class button{
  float x,y,w,h;
  String name = "";
  boolean selected;
  button(String _name, float _x, float _y, float _w, float _h){
    name = _name; x = _x; y = _y; w = _w; h = _h;
  }
  void show(){
    textAlign(CENTER);
    rectMode(CENTER);
    strokeWeight(mouseOver()?2:1);
    stroke(selected?color(255,0,0):0);
    fill(255);
    rect(x,y,w,h);
    fill(0);
    text(name,x,y,w-2,h);
  }
  boolean mouseOver(){
    if(mouseX>=x-w/2 && mouseX<=x+w/2 && mouseY>=y-h/2 && mouseY<=y+h/2){
      return true;
    }else return false;
  }
}
