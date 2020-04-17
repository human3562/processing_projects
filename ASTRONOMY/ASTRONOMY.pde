float elapsedTime = 0;
float timeScale = 1;
void setup(){
  //fullScreen(P2D);
  size(600,600);
  aBody b1 = new aBody(width/2,height/2,20,600000);
  aBody b2 = new aBody(width/2-50,height/2,5,500);
  aBody b3 = new aBody(width/2+60,height/2,5,500);
  b3.velocity.y = 300;
  b2.velocity.y = -300;
  bodies.add(b1);
  bodies.add(b2);
  bodies.add(b3);
  //bodies.add(new aBody(width/2, height/2, 20, 50000));
}
void draw(){
  elapsedTime = timeScale * 1/frameRate;
  background(0);
  pushMatrix();
  scale(zoom);
  translate(-offsetX, -offsetY);
  
  cUpdate();
  physics();
  
  for(aBody b : bodies){
    b.show(); 
  }
  
  ellipse(width/2, height/2, 10,10);
  
  popMatrix();
  fill(255);
  text("Zoom amount: "+zoom,10,10);
  text("FPS: "+frameRate,10,25);
  text("timeScale: " + timeScale, 10, 40);
}
