//String level = ""; //<>//
Level level;
PImage block;
PImage brick1;
PImage brick2;
PImage brick3;
ArrayList<Tile> tiles = new ArrayList<Tile>();
Player player;
int tileWidth = 64;
int tileHeight = 64;
//int levelWidth, levelHeight;
float cameraPosX, cameraPosY;
int visibleTilesX, visibleTilesY;
float deltaTime;
float offsetX, offsetY;

//regiansssssssssssssssssssss
void setup() {
  size(704, 704, P2D);
  //fullScreen(P2D);
  block = loadImage("BLOCK.png");
  brick1 = loadImage("BRICK.png");
  brick2 = loadImage("BRICK2.png");
  brick3 = loadImage("BRICK3.png");
  level = new Level();
  setLevel(level, 0);

  for (int i = 0; i<level.levelString.length(); i++) {
    //print(level.charAt(i)+" ");
    tiles.add(new Tile(i, level.levelString.charAt(i)));
  }

  rectMode(CORNERS);
  imageMode(CORNERS);
  player = new Player();

  visibleTilesX = width/tileWidth+1;
  visibleTilesY = height/tileHeight;
  noStroke();
  frameRate(144);
}
void draw() {
  deltaTime = 1/frameRate;
  background(124, 252, 255);
  //scale(2);

  player.update();
  for (Tile t : tiles) {
    t.update();
  }

  cameraPosX = player.pos.x + 0.8;
  cameraPosY = player.pos.y - 0.2;

  offsetX = cameraPosX - visibleTilesX / 2;
  offsetY = cameraPosY - visibleTilesY / 2;

  if (offsetX<0) offsetX = 0;
  if (offsetY<0) offsetY = 0;
  if (offsetX>level.Width - visibleTilesX) offsetX = level.Width - visibleTilesX;
  if (offsetY>level.Height - visibleTilesY) offsetY = level.Height - visibleTilesY;

  float tileOffsetX = (offsetX - int(offsetX)) * tileWidth;
  float tileOffsetY = (offsetY - int(offsetY)) * tileHeight;

  //noStroke();
  //draw level
  for (int x = -1; x < visibleTilesX + 1; x++) {
    for (int y = -1; y < visibleTilesY + 1; y++) {
      Tile tileID = tiles.get(GetTile(x + int(offsetX), y + int(offsetY)));
      if (tileID.img != null)
        switch(tileID.ch) {
        case '#':
          image(tileID.img, x*tileWidth-tileOffsetX, y*tileHeight-tileOffsetY - tileID.anim, (x+1) * tileWidth - tileOffsetX, (y+1) * tileHeight - tileOffsetY - tileID.anim);
          break;
        case 'B':
          image(tileID.img, x*tileWidth-tileOffsetX, y*tileHeight-tileOffsetY - tileID.anim, (x+1) * tileWidth - tileOffsetX, (y+1) * tileHeight - tileOffsetY - tileID.anim);
          break;
        case '.':
          break;
        default:
          break;
      }
    }
  }



  //draw player
  fill(0, 255, 0);
  noStroke();
  rect((player.pos.x - offsetX) * tileWidth, (player.pos.y - offsetY) * tileHeight, (player.pos.x - offsetX + 1) * tileWidth, (player.pos.y - offsetY + 1) * tileHeight);
  fill(0);
  text("FPS: "+floor(frameRate), 3, 12);
  text(player.vel.y, 3, 22);
  //stroke(0);
  //line(0,height/2,width,height/2);
  //line(width/2,0,width/2,height);
}
