//0 - notexture
//1 - solid block
//2 - brick1
//3 - brick2
//4 - brick3
//5 - upperGround
//6 - lowerGround
//7 - BGbrick
class Images {
  ArrayList<PImage> textureImages = new ArrayList<PImage>();
  ArrayList<PImage> fragments = new ArrayList<PImage>();
  PImage[] coin = new PImage[60];
  PImage turret;
  PImage notexture;
  PImage block;
  PImage brick;
  PImage brick2;
  PImage brick3;
  PImage upperGround;
  PImage lowerGround;
  PImage BGbrick;
  PImage ladder1;
  PImage ladder2;
  PImage trunk;
  PImage body;
  PImage top1;
  PImage top2;
  PImage top3;
  PImage top4;
  PImage top5;
  PImage top6;
  PImage sky;
  PImage dirt;
  PImage bullet;
  PImage gg;
  PImage god;
  PImage LVL;
  PImage grenade;
  
  PImage drinkmachine;

  PImage playerIdle;
  
  PImage[] playerHolo = new PImage[24];
  PImage[] playerWalk = new PImage[4];
  PImage[] playerJump = new PImage[5];
  PImage[] playerJetpack = new PImage[8];

  PImage grenadeICON;

  Images(){
    PImage f1 = loadImage("textures/fragment1.png");
    PImage f2 = loadImage("textures/fragment2.png");
    PImage f3 = loadImage("textures/fragment3.png");
    PImage f4 = loadImage("textures/fragment4.png");
    fragments.add(f1);
    fragments.add(f2);
    fragments.add(f3);
    fragments.add(f4);



    playerIdle = loadImage("textures/player/idle.png");
    grenadeICON = loadImage("textures/weapons/grenade.png");

    LVL = loadImage("level1.png");
    gg = loadImage("textures/GG.png");
    god = loadImage("textures/GOD.png");
    bullet = loadImage("textures/bullet.png");
    dirt = loadImage("textures/dirt.png");
    notexture = loadImage("textures/NOTEXTURE.png");
    block = loadImage("textures/BLOCK.png");
    brick = loadImage("textures/BRICK.png");
    brick2 = loadImage("textures/BRICK2.png");
    brick3 = loadImage("textures/BRICK3.png");
    upperGround = loadImage("textures/GROUND.png");
    lowerGround = loadImage("textures/GROUND2.png");
    BGbrick = loadImage("textures/UBRICK.png");
    ladder1 = loadImage("textures/LADDER1.png");
    ladder2 = loadImage("textures/LADDER2.png");
    trunk = loadImage("textures/TRUNK.png");
    body = loadImage("textures/BODY.png");
    top1 = loadImage("textures/TOP1.png");
    top2 = loadImage("textures/TOP2.png");
    top3 = loadImage("textures/TOP3.png");
    top4 = loadImage("textures/TOP4.png");
    top5 = loadImage("textures/TOP5.png");
    top6 = loadImage("textures/TOP6.png");
    sky = loadImage("textures/sky.png");
    turret = loadImage("textures/TURRET.png");
    grenade = loadImage("textures/weapons/granata.png");
    
    for(int i = 0; i<playerHolo.length; i++){
      playerHolo[i] = loadImage("textures/player/holo/"+(i+1)+".png"); 
    }
    
    for(int i = 0; i<playerWalk.length; i++){
      playerWalk[i] = loadImage("textures/player/wheelz/"+(i+1)+".png"); 
    }
    
    for(int i = 0; i<playerJump.length; i++){
      playerJump[i] = loadImage("textures/player/jump/"+(i+1)+".png"); 
    }
    
    for(int i = 0; i<playerJetpack.length; i++){
      playerJetpack[i] = loadImage("textures/player/jetpack/"+(i+1)+".png"); 
    }
    
    for(int i = 0; i<4; i++){
     println(playerJump[i]);
    }
    
    drinkmachine = loadImage("textures/drinksmachine/1.png");
    
    for (int i = 0; i<coin.length; i++) {
      if (i == 0) {
        coin[i] = loadImage("textures/coinsprites/0001.png");
        continue;
      }
      String desiredSprite = "";
      if (i<10) desiredSprite = "000"+i;
      else if (i<100) desiredSprite = "00"+i;
      else if (i>=100) desiredSprite = "0"+i;
      coin[i] = loadImage("textures/coinsprites/"+desiredSprite+".png");
    }

    textureImages.add(notexture);
    textureImages.add(block);
    textureImages.add(brick);
    textureImages.add(brick2);
    textureImages.add(brick3);
    textureImages.add(upperGround);
    textureImages.add(lowerGround);
    textureImages.add(BGbrick);
    textureImages.add(trunk);
    textureImages.add(body);
    textureImages.add(top1);
    textureImages.add(top2);
    textureImages.add(top3);
    textureImages.add(top4);
    textureImages.add(top5);
    textureImages.add(top6);
  }
}
