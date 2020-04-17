float offsetX, offsetY;
float scl = 1;
player Player;
int currentLevel = 0;
ArrayList<level> levels = new ArrayList<level>();
ArrayList<turret> turrets = new ArrayList<turret>();
float elapsedTime = 0;
float camspeed = 300;
float totaltime = 0;
float timestep = 1;
float globaltimescaled=0;
float targettimescale = 1;
float fade = 0;
float grenadetime = 1;
boolean showDebug = true;
float bgscale = 3;
Images images;
void setup() {
  size(1200, 600, P3D);
  //fullScreen(P3D);
  images = new Images();
  noSmooth();
  ((PGraphicsOpenGL)g).textureSampling(2);
  //smooth(0);
  frameRate(120);
  imageMode(CENTER);
  rectMode(CENTER);
  
  declareItems();
  
  Player = new player();
  Player.xPosition = 64*2;
  Player.yPosition = 64*2;
  //smooth(0);
  
  setLevels();
  levels.get(currentLevel).blocks.get(56).isCoin = true;
  setFish();
  textMode(MODEL);
  textSize(24);
  textSize(12);
  //blendMode(ADD);
}

void draw() {
  elapsedTime = 1/frameRate * timestep;
  if(frameCount<120) elapsedTime = 0.005;
  background(255);
  slow();
  fade();
  pushMatrix();
  translate(offsetX*scl, offsetY*scl);
  scale(scl);
  pushMatrix();
  translate(0,0, -200);
  imageMode(CENTER);
  image(images.sky,(levels.get(currentLevel).levelWidth*64/2), (levels.get(0).levelHeight*64)/2,levels.get(currentLevel).levelWidth*64+500,levels.get(currentLevel).levelHeight*64+250);
  //image(sky,3365,1726);
  image(images.gg,width/2-300,height-200);

  popMatrix();
  
  if(images.LVL!=null){
    imageMode(CORNERS);
    //image(images.LVL,0,0,images.LVL.width*2,images.LVL.height*2);
    imageMode(CENTER);
  }
  
  if (!levels.isEmpty()) {
    if (!levels.get(currentLevel).isStarted) {
      levels.get(currentLevel).Start(); 
      levels.get(currentLevel).isStarted = true;
    }
    //println("waddup");
    //println(currentLevel);
    levels.get(currentLevel).Update();
  }

  if (!grenades.isEmpty()) {
    for (grenade g : grenades) {
      g.update(elapsedTime);
    }
    removeGrenades();
  }

  if (throwX!=0||throwY!=0) {
    pushMatrix();
    translate(0, 0, 1);
    pathP p = new pathP(Player.xPosition, Player.yPosition, cos(ta) * -td + Player.xspeed, sin(ta) * -td + Player.yspeed, grenadetime, color(255, 0, 0, 50));
    strokeWeight(2);
    stroke(p.c);
    float time =0;
    while (!p.finished) {
      float px = p.xPosition;
      float py = p.yPosition;
      p.update(0.0000001*time);
      //p.update(elapsedTime);
      line(px, py, p.xPosition, p.yPosition);
      time++;
    }
    fill(255, 0, 0);
    noStroke();
    ellipse(p.xPosition, p.yPosition, 10, 10);
    popMatrix();
  }
  
  if (!characters.isEmpty()) {
    for (character c : characters) {
      c.show();
    }
  }
  Player.update();
  
  if (!particles.isEmpty()) {
    for (particle part : particles) {
      part.update();
    }
    removeParticles();
  }
  Player.show();


  if (!bullets.isEmpty()) {
    for (projectile p : bullets) {
      p.update();
    }
    removeBullets();
  }


  if (!turrets.isEmpty()) {
    for (turret t : turrets) {
      t.update();
    }
    removeTurrets();
  }


  if (Player.yPosition<0&&cutscenes.isEmpty()) {
    godCutscene();
  }

  if (!cutscenes.isEmpty()) {
    for (cutscene c : cutscenes) {
      if (!c.started) {
        c.Start();
      } else
        c.update();
    }
    removeCutscenes();
  }

  if (td>0) {
    pushMatrix();
    translate(Player.xPosition, Player.yPosition);
    rotate(ta);
    //println(ta);
    stroke(map(td, 0, 1000, 0, 255), map(td, 0, 1000, 255, 0), 0);
    textAlign(CENTER);
    fill(0);
    if (ta>-PI/2&&ta<PI/2) {
      text(round(td/1000*100) +"%", -td*0.25/2, 0);
    } else {
      pushMatrix();
      rotate(PI);
      text(round(td/1000*100) +"%", td*0.25/2, 0);
      popMatrix();
    }
    line(0, 0, -td*0.25, 0);
    popMatrix();
  }


  popMatrix();


  fill(0, 0, 0, fade);
  noStroke();
  //println(fade);
  rect( width/2, height/2, width, height);

  if (!characters.isEmpty()) {
    for (character c : characters) {
      if (talkto!=-1) {
        //targetFade = 170;
        if (c == characters.get(talkto)) {
          imageMode(CORNER);
          c.update();
          if (!c.equals("character")) {
            c.checkAnswerLog();
          }
        }
      }
    }
  }
  Player.inventory.show();
  textSize(12);
  if (showDebug) {
    textAlign(LEFT);
    fill(0);
    text("FPS: "+round(frameRate), 10, 15);
    text("speedX: "+Player.xspeed+"pixels per second", 10, 30);
    text("speedY: "+Player.yspeed+"pixels per second", 10, 45);
    text("Player dead: "+ ((Player.isDead)?"true":"false"), 10, 60);
    text("Player on ladder: "+((Player.onLadder)?"true":"false"), 10, 75);
    text("Player hp: " + Player.hp, 10, 90);
    text("Particles array size: " + particles.size(), 10, 105);
    text("Camera TL: "+ -offsetX, 10, 120);
    text("Time spent: " + floor(totaltime) + " seconds.", 10, 135);
    text("Time step multiplier: "+timestep, 10, 150);
    text("Characters size: "+characters.size(), 10, 165);
    text("Player jetpack: "+((Player.jumped)?"true":"false"),10,180);
    text("Current player frame: "+Player.curtxtId,10,195);
    text("time AFK: "+Player.AFKtime,10,210);
    //line(width/2, 0, width/2, height);
    //if (mouseX+60>width)
    //    offsetX-=camspeed * elapsedTime;
    //  if (mouseX-60<0)
    //   offsetX+=camspeed * elapsedTime;
    //  if (mouseY+60>height)
    //    offsetY-=camspeed * elapsedTime;
    //  if (mouseY-60<0)
    //    offsetY+=camspeed * elapsedTime;
  }
  //pushMatrix();
  //translate(0,0,1);
  //fill(0,100);
  //ellipse(width-150,height-150,200,200);
  //popMatrix();
  offsetX = lerp(offsetX,-(Player.xPosition) + ((width/2)/scl), elapsedTime*6);
  offsetY = lerp(offsetY,-(Player.yPosition) + ((height/2)/scl) + (Player.jumped?32:0),elapsedTime*6);
  if (offsetX>0) offsetX = 0;
  if (offsetX - width/scl < -levels.get(0).levelWidth*64) offsetX = -(levels.get(0).levelWidth*64-width/scl);
  if (offsetY>0) offsetY = 0;
  if (offsetY - height/scl < -levels.get(0).levelHeight*64) offsetY = -(levels.get(0).levelHeight*64-height/scl);
  globaltimescaled +=elapsedTime;
  totaltime += 1/frameRate;

}
