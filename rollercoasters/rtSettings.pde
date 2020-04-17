
class circleSelect{
  float x, y;
  float r = 20;
  //boolean mOver = false;
  circleSelect(float x, float y){
     this.x = x;
     this.y = y;
  }
  boolean mOver(){
     return (PVector.dist(new PVector(mouseX, mouseY), new PVector(x,y)) < r); 
  }
  void show(){
    stroke(255);
    strokeWeight(1);
    fill(mOver()?255:140);
    ellipse(x,y,r*2,r*2);
    textSize(20);
    textAlign(LEFT,CENTER);
    fill(255);
    text("G = ("+nf(g.x/G,1,2)+"; "+nf(g.y/G,1,2)+")",x+25,y);
  }
}

float gSelectA = PI/2;
void updateSetting(){
  if(sDown){
    gSelectA = atan2(mouseY - height/2, mouseX - width/2); 
  }
  gSelect.x = (cos(gSelectA)*100) + width/2;
  gSelect.y = (sin(gSelectA)*100) + height/2;
  g.x = cos(gSelectA)*G;
  g.y = sin(gSelectA)*G;
  stroke(255);
  line(width/2, height/2, gSelect.x, gSelect.y);
  gSelect.show();
}
