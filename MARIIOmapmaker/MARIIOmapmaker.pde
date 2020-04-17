ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<PImage> textures = new ArrayList<PImage>();
ArrayList<Button> textureButtons = new ArrayList<Button>();
int tileWidth = 64;
int tileHeight = 64;
float cameraPosX, cameraPosY;
float offsetX, offsetY;
float visibleTilesX, visibleTilesY;
int levelWidth, levelHeight;
int focusedTile;
//PImage notexture;
//PImage block;
boolean up, right, down, left;
boolean menuUp = false;
int selectedTexture;
Button b;
Menu menu;


void setup() {
  size(1024, 640, P2D);
  //fullScreen();
  //frameRate(40);
  rectMode(CORNERS);
  imageMode(CORNERS);
  b = new Button("ass", null, width-200, 10, width-10, 30, -1, true);
  menu = new Menu();
  //notexture = loadImage("NOTEXTURE.png");
  //block = loadImage("BLOCK.png");
  textures.add(loadImage("NOTEXTURE.png"));
  textures.add(loadImage("BLOCK.png"));
  textures.add(loadImage("BRICK.png"));
  textures.add(loadImage("GROUND.png"));
  textures.add(loadImage("GROUND2.png"));
  textures.add(loadImage("COIN.png"));
  textures.add(loadImage("UBRICK.png"));

  for (int i = 0; i<textures.size(); i++) {
    textureButtons.add(new Button(null, textures.get(i), 0, 20 + ((64+20) * ceil(i/3)), 0, 20 + 64 + ((20+64) * ceil(i/3)), i, true));
  }

  visibleTilesX = width/tileWidth;
  visibleTilesY = height/tileHeight;
  levelWidth = 64;
  levelHeight = 16;
  for (int i = 0; i<levelWidth*levelHeight; i++) {
    tiles.add(new Tile(i, 0));
  }
}


void draw() {
  background(124, 252, 255); 
  cInput();
  for (Tile t : tiles)
    t.update();
  if (!menu.mouseOver)
    focusedTile = GetTile(int(mouseX/tileWidth+offsetX), int(mouseY/tileHeight+offsetY));
  else focusedTile = -1;
  visibleTilesX = width/tileWidth;
  visibleTilesY = height/tileHeight;
  offsetX = cameraPosX - visibleTilesX / 2;
  offsetY = cameraPosY - visibleTilesY / 2;
  if (offsetX<0) offsetX = 0;
  if (offsetY<0) offsetY = 0;
  if (offsetX>levelWidth - visibleTilesX) offsetX = levelWidth - visibleTilesX;
  if (offsetY>levelHeight - visibleTilesY) offsetY = levelHeight - visibleTilesY;
  float tileOffsetX = (offsetX - int(offsetX)) * tileWidth;
  float tileOffsetY = (offsetY - int(offsetY)) * tileHeight;
  //float tileOffsetX = (offsetX - ceil(offsetX)) * tileWidth;
  //float tileOffsetY = (offsetY - ceil(offsetY)) * tileHeight;

  for (int x = -2; x < visibleTilesX + 2; x++) {
    for (int y = -1; y < visibleTilesY + 1; y++) {
      if (GetTile(x + int(offsetX), y + int(offsetY)) != -1) {
        Tile tileID = tiles.get(GetTile(x + int(offsetX), y + int(offsetY)));
        if (tileID.id == focusedTile) {
          noFill(); 
          stroke(0);
          strokeWeight(2);
          rect(x*tileWidth-tileOffsetX, y*tileHeight-tileOffsetY, (x+1) * tileWidth - tileOffsetX, (y+1) * tileHeight - tileOffsetY);
        } 
        if (tileID.img != null) {
          if (tileID.textureId != 0) {
            image(tileID.img, x*tileWidth-tileOffsetX, y*tileHeight-tileOffsetY, (x+1) * tileWidth - tileOffsetX, (y+1) * tileHeight - tileOffsetY);
          }
        }
      }
    }
  }
  menu.update();
  b.x2 = menu.x1;
  b.x1 = menu.x1 - 32;
  b.update();
  //if(b.isPressed)
  //  b.c = color(255,0,255);
  //else b.c = color(255,255,255);
  b.show();
  menuUp = b.isPressed;
  textAlign(LEFT);
  for (Button b : textureButtons) { //<>//
    b.update(); //<>//
    b.x1 = (menu.x1+20) + ((64+20) * (b.id % 3)); //<>//
    b.x2 = (menu.x1+20+64) + ((64+20) * (b.id % 3)) ; //<>//
    //print(b.x1); //<>//
    b.show(); //<>//
    if(b.isPressed)
      selectedTexture = b.id;
  } //<>//
  print(" ");
  fill(0);
  ellipse((cameraPosX - offsetX) * tileWidth, (cameraPosY - offsetY) * tileHeight, 10, 10);
  text(focusedTile, 10, 10);
  text(offsetX, 10, 30);
  text(offsetY, 10, 50);
}
