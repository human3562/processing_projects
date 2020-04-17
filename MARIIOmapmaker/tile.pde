class Tile{
  PImage img;
  boolean isSolid;
  boolean isPickUp;
  boolean isDestructible;
  int hp;
  int id;
  int textureId;
  Tile(int idt, int textureidt){
    id = idt;
    textureId = textureidt;
  }
  
  void update(){
    if(textureId != 0){
      img = textures.get(textureId);
    }else img = null;
  }
  
}
