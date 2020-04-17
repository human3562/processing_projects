class Tile {
  char ch;
  PImage img;
  int id;
  int hp;
  int t = 0;
  int cnst = 20;
  float anim = 0;
  Tile(int idt, char cht) {
    ch = cht;
    id = idt;
    switch (ch){
      case '#':
        img = block;
        break;
      case 'B':
        img = brick1;
        break;
      default:
        //no texture
        break;
    }
    if (ch == 'B')
      hp = 5;
  }

  void update() {
    
    if (t > 0) {
      anim = cnst-t;
    }
    if (t < 20)
      t++;
    if (hp <= 0 && ch == 'B') {
      explode();
    }
  }

  void hit() {
    if (ch == 'B') {
      //anim = 20;
      t = -2;
      hp--;
      if(hp<5 && hp > 1){
        img = brick2;
      }else if(hp == 1){
        img = brick3; 
      }
    }
  }

  void explode() {
    ch = '.';
    //can add some effects later
  }
}
