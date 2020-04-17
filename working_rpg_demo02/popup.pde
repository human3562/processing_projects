class popup {
  String text;
  float duration = 10;
  float time;
  float yoff;
  float x = width-200;
  float y;
  float a = 5;
  float b = 255;
  float c = 0;
  float delay = 0;
  int id;
  boolean isStarted = false;
  //boolean remove = false;
  boolean completed = false;

  popup(String txt, float _dur, float popdelay) {
    id = popups.size();
    text = txt;
    duration = _dur;
    delay = popdelay;
    time = -delay;
  }

  void Start() {
  }

  void update() {
    if (time>0) {
      if (time>duration)
        completed = true;
      //if(remove){
      //  x+=c*c;
      //  c+=1;  
      //}
      yoff = a*a*a*a;
      y = height-150+yoff;
      noStroke();
      x = (width-200) + 1/(b*b) * 20;
      fill(200);
      rect(x, y, 200, (20 + 85 * map(text.length(), 0, 100, 0, 1)) + 4);
      fill(0);
      textSize(18);
      textAlign(LEFT);
      text(text, x+2, y, 198, 6000);
      if (a>0)
        a-=4 * deltaTime;
      if (time>=0)
        b = map(time, 0, duration, 10, 0);
    }
    time += 1/frameRate;
  }
}
