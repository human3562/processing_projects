import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_191023a extends PApplet {

PVector Vwind;
float maxWindV = 20;

PVector G = new PVector(0, 9.81f);

float windBallX; 
float windBallY;

float camX;
float camY;

int PROGRAM_STATE = 1; 
//0 - playground;
//1 - launchsetting;
//2 - simulating;

s_playground playground;
s_launchSetting launchSetting;
s_review review;

public void setup() {
   
  
  //fullScreen(1);
  camX = -width/2;
  camY = -height/2;
  //float d = random(0, maxWindV);
  //float a = random(0, TWO_PI);
  //Vwind = new PVector(cos(a)*0, sin(a)*0);
  //ball = new body();
  playground = new s_playground();
  launchSetting = new s_launchSetting();
  review = new s_review();
}

public void draw() {
  switch(PROGRAM_STATE) {
  case 0:
    if (!playground.isStarted) {
      playground.Start();
      playground.isStarted = true;
    } else {
      playground.Update();
    }
    break;
  case 1:
    if (!launchSetting.isStarted) {
      launchSetting.Start();
      launchSetting.isStarted = true;
    } else {
      launchSetting.Update();
    }
    break;
  case 2:
    if (!review.isStarted) {
      review.Start();
      review.isStarted = true;
    } else {
      review.Update();
    }
    break;
  default: 
    PROGRAM_STATE = 0;
    break;
  }
}

public void drawMap() {
  strokeWeight(1);
  stroke(40);
  for (int i = floor((camX)/pixelScale); i < ceil((camX+width)/pixelScale); i+=1) {
    line(i*pixelScale, camY, i*pixelScale, camY+height);
  }
  for (int i = floor(camY/pixelScale); i < ceil((camY+height)/pixelScale); i+=1) {
    line(camX, i*pixelScale, camX+width, i*pixelScale);
  }
}

public void info(body ball) {
  fill(0);
  stroke(100);
  strokeWeight(1);
  rectMode(CORNERS);
  rect(-1, -1, 280, 100);
  fill(255);
  textAlign(LEFT);
  textSize(10);
  text("FPS: "+nfc(frameRate, 2), 10, 10);
  text("Координата X: "+ nfc(ball.position.x, 2) +"m;", 10, 25);
  text("Координата Y: "+nfc(ball.position.y, 2)+"m", 130, 25);
  text("Скорость X: "+nfc(ball.velocity.x, 2)+"m/s;", 10, 40);
  text("Скорость Y: "+nfc(ball.velocity.y, 2)+"m/s", 130, 40);
  text("Ускорение X: "+nfc(ball.acceleration.x, 2)+"m/s²;", 10, 55);
  text("Ускорение Y: "+nfc(ball.acceleration.y, 2)+"m/s²", 130, 55);
  text("Высота: "+nfc(ball.groundLevel - ball.position.y, 2)+"m", 10, 70);
}


boolean settingWind = false;
public void drawWindDirection(body ball, float x, float y, boolean canChange) {

  if (settingWind && canChange == true) {
    if (dist(mouseX, mouseY, windBallX, windBallY) < 100) {
      float sx = -(windBallX - mouseX)/100;
      float sy = -(windBallY - mouseY)/100;
      Vwind.x = maxWindV * sx;
      Vwind.y = maxWindV * sy;
    }
  }

  noStroke(); 
  fill(0);
  ellipse(x, y, 200, 200);
  fill(255);
  ellipse(x, y, 15, 15);
  noFill();
  stroke(255);
  strokeWeight(1);
  ellipse(x, y, 200, 200);

  pushMatrix();
  translate(x, y);
  float a = atan2(Vwind.y, Vwind.x) + HALF_PI;
  rotate(a);
  float ypos = map(Vwind.mag(), 0, maxWindV, 0, -100);
  strokeWeight(2);
  line(0, 0, 0, ypos);
  fill(255);
  beginShape();
  vertex(0, ypos);
  vertex(5, ypos+10);
  vertex(-5, ypos+10);
  endShape(CLOSE);
  popMatrix();

  fill(200);
  textAlign(CENTER);
  textSize(20);
  text(nfc(Vwind.mag(), 2)+"m/s", x, y+50);

  fill(255);
  textAlign(RIGHT);
  textSize(23);
  text("Направление ветра", x+100, y+130);
}
float pixelScale = 40; //how much pixels in one meter

class body {

  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector F;
  float Vmax = 20;
  float mass = 1;


  float wBound = 0; //0 for infinite
  float hBound = 0; //0 for infinite
  float groundLevel = 10;

  float R = 0.25f; //radius
  float h = 0;

  boolean showVectors = true;
  boolean mouseMove = false;

  float dT = 0.1f;
  
  float lifeT = 10;
  
  boolean hitGround;

  body() {
    position = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    F = new PVector(0, 0);
    hitGround = false;
    lifeT = 0;
  }

  public void update() {

    //PVector Fres;
    PVector U = PVector.sub(velocity, Vwind);
    float mU = U.mag();
    //Fres = PVector.mult(PVector.div(PVector.mult(U, mU), Vmax*Vmax), -mass*G.mag());
    if (hBound != 0 && wBound != 0)
      h = hBound - position.y;
    else h = groundLevel - position.y;
    //Fres = PVector.mult(Fres, exp(-h/10000));

    //F = PVector.add(G, Fres);

    acceleration = PVector.sub(G, PVector.mult(PVector.mult(PVector.div(PVector.mult(U, mU), Vmax*Vmax), G.mag()), exp(-h/10000))); 
    //a = g - g.mag() * ( (U * U.mag()) / (Vmax * Vmax) ) * exp(-h/10000); 

    velocity = PVector.add(velocity, PVector.mult(acceleration, dT));

    if (mouseMove) {
      float my = ((mouseY+camY)/pixelScale) - position.y;
      float mx = ((mouseX+camX)/pixelScale)  - position.x;
      //float a = atan2(my, mx);
      velocity = PVector.div( PVector.add(velocity, new PVector(mx/2, my/2)), 1.001f);
    }

    if (hBound != 0 && wBound != 0) {
      if (position.x+velocity.x*dT > wBound-R) {
        position.x = wBound-R;
        velocity.x *= -0.8f;
      }
      if (position.x+velocity.x*dT < -wBound+R) {
        position.x = -wBound+R;
        velocity.x *= -0.8f;
      }
      if (position.y+velocity.y*dT > hBound-R) {
        position.y = hBound-R;
        velocity.y *= -0.8f;
      }
      if (position.y+velocity.y*dT < -hBound+R) {
        position.y = -hBound+R;
        velocity.y *= -0.8f;
      }
    } else {
      if (position.y+velocity.y*dT > groundLevel-R) {
        position.y = groundLevel-R;
        velocity.y *= -0.8f;
        hitGround = true;
      }
    }

    position = PVector.add(position, PVector.mult(velocity, dT));
    lifeT += dT;
  }

  public void show() {
    pushMatrix();
    translate(width/2, height/2);
    stroke(255);
    strokeWeight(1);
    if (hBound != 0 && wBound != 0) {
      line(( wBound * pixelScale) - width/2, (-hBound * pixelScale) - height/2, ( wBound * pixelScale) - width/2, ( hBound * pixelScale) - height/2);
      line(( wBound * pixelScale) - width/2, ( hBound * pixelScale) - height/2, (-wBound * pixelScale) - width/2, ( hBound * pixelScale) - height/2);
      line((-wBound * pixelScale) - width/2, ( hBound * pixelScale) - height/2, (-wBound * pixelScale) - width/2, (-hBound * pixelScale) - height/2);
      line((-wBound * pixelScale) - width/2, (-hBound * pixelScale) - height/2, ( wBound * pixelScale) - width/2, (-hBound * pixelScale) - height/2);
    }
    noStroke();
    fill(255);
    ellipse((position.x * pixelScale) - width/2, (position.y * pixelScale) - height/2, 2*R*pixelScale, 2*R*pixelScale);
    if (showVectors) drawVectors();
    popMatrix();
  }

  public void drawVectors() {
    strokeWeight(1);
    stroke(255, 0, 0);
    line((position.x * pixelScale) - width/2, (position.y * pixelScale) - height/2, ((position.x * pixelScale) + velocity.x * pixelScale) - width/2, ((position.y* pixelScale)+velocity.y*pixelScale) - height/2);
    stroke(0, 255, 0);
    line((position.x * pixelScale) - width/2, (position.y * pixelScale) - height/2, ((position.x*pixelScale)+acceleration.x*pixelScale) - width/2, ((position.y*pixelScale)+acceleration.y*pixelScale) - height/2);
  }

  public boolean mouseOver() {
    //if (mouseX-width/2>-wBound*pixelScale && mouseX-width/2<wBound*pixelScale && mouseY-height/2>-hBound*pixelScale && mouseY-height/2<hBound*pixelScale) {
    float mX = (mouseX+camX)/pixelScale;
    float mY = (mouseY+camY)/pixelScale;
    return(dist(position.x, position.y, mX, mY)<R);
    //} else return false;
  }
}


//ArrayList<button> buttons = new ArrayList<button>();
class settingsA {
  ArrayList<setting> settings = new ArrayList<setting>();
  int selected = 0;
  public void show() {
    if (!settings.isEmpty()) {
      for (setting s : settings) s.selected = false; 
      settings.get(selected).selected = true;
      for (setting s : settings) s.show();
    }
  }
  public void update() {
    if (!settings.isEmpty()) {
      if ((keyCode == 'w' || keyCode == 'W' || keyCode == UP) && selected>0) selected--;
      else if ((keyCode == 's' || keyCode == 'S' || keyCode == DOWN) && selected<settings.size()-1) selected++;
      else settings.get(selected).update();
    }
  }
  public void mouseUpdate() {
    if (!settings.isEmpty()) {
      for (setting s : settings) if (s.mOver) s.update();
    }
  }
}

class setting {
  boolean active = true;
  boolean act = false;
  int value = 0;
  boolean selected = false;
  String name = "";
  boolean mOver = false;
  String strvalue;
  public void show() {
  }//this function should include mouseOver
  public void update() {
  }//call this in keyPressed
}

class valueBox extends setting {
  float x, y;
  float fontSize = 24;
  valueBox(String _name, float _x, float _y, String defaultVal) {
    name = _name;
    x = _x;
    y = _y;
    strvalue = defaultVal;
  }
  public void show() {
    stroke((selected?color(200, 0, 0):color(180)));
    strokeWeight(selected?3:2);
    fill(255);
    rectMode(CORNER);
    rect(x, y, fontSize * 8, fontSize);
    textAlign(LEFT);
    textSize(fontSize);
    text(name, x, y - 4);
    fill(0);
    text(strvalue, x+2, y + fontSize - 2);
  }
  public void update() {
    if (key == '.' || key == '-' || key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
      strvalue += key;
    }
    if (key == BACKSPACE) {
      if (!strvalue.isEmpty())
        strvalue = strvalue.substring(0, strvalue.length()-1);
    }
  }
}

class bool extends setting {
  float x, y;
  bool(String _name, float _x, float _y, boolean defaultVal) {
    name = _name;
    x = _x;
    y = _y;
    act = defaultVal;
  }
  public void show() {
    mOver = (mouseX > x && mouseX < x+40 && mouseY > y-10 && mouseY < y+10);
    fill(255);
    stroke(180);
    strokeWeight(8);
    line(x, y, x+40, y);
    strokeWeight(1);
    stroke((mOver?color(255, 0, 0):color(180)));
    ellipse((act == false)?x:x+40, y, 20, 20);
    textAlign(LEFT, CENTER);
    textSize(20);
    text(name+(act?": ВКЛ":": ВЫКЛ"), x+60, y-4);
  }
  public void update() {
    if (mouseX > x && mouseX < x+40 && mouseY > y-10 && mouseY < y+10) act = !act;
    if (keyCode == ENTER || keyCode == RETURN) act = !act;
    if (keyCode == 'a' || keyCode == 'A' || keyCode == LEFT) act = false;
    if (keyCode == 'd' || keyCode == 'D' || keyCode == RIGHT) act = true;
  }
}
class slider extends setting {
  float x, y;
  int min, max;
  slider(String _name, float _x, float _y, int minAmt, int maxAmt, int defAmt) {
    name = _name;
    x = _x;
    y = _y;
    min = minAmt;
    max = maxAmt;
    value = defAmt;
  }
  public void show() {
    fill(255);
    stroke(180);
    strokeWeight(8);
    line(x, y, x+200, y);
    strokeWeight(1);
    stroke((selected?color(255, 0, 0):color(180)));
    ellipse(map(value, min, max, x, x+200), y, 20, 20);
    textAlign(LEFT, CENTER);
    textSize(20);
    text(name+": "+value, x+220, y-4);
  }
  public void update() {
    if (keyCode == 'a' || keyCode == 'A' || keyCode == LEFT) {
      if (value>min) value--;
    }
    if (keyCode == 'd' || keyCode == 'D' || keyCode == RIGHT) {
      if (value<max) value++;
    }
  }
}
class button extends setting {
  float x, y, w, h;
  //boolean activated = false;
  button(String _name, float _x, float _y, float _w, float _h) {
    name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  public void show() {
    rectMode(CENTER);
    fill(180);
    stroke(0);
    if (selected) {
      stroke(255, 0, 0);
      strokeWeight(3);
      mOver = true;
    } else {
      noStroke();
      mOver = false;
    }
    rect(x, y, w, h);
    fill(0);
    if (act) fill(255, 0, 0);
    act = false;
    textAlign(CENTER, CENTER);
    text(name, x, y);
  }
  public void update() {
    if (mouseX>x-w/2 && mouseX<x+w/2 && mouseY>y-h/2 && mouseY<y+h/2) {
      act = true;
    }
    if (keyCode == ENTER || keyCode == RETURN) act = true;
  }
}

class timeSlider {
  int points;
  float startX; float endX; float h;
  int currentPoint = 0;
  float x;
  
  boolean mousePress = false;
  
  
  public void show(){
    stroke(255);
    strokeWeight(1);
    line(startX, h, endX, h);
    fill(255);
    noStroke();
    if(mousePress) currentPoint = floor(map(mouseX, startX, endX, 0, points-1)); 
    if(currentPoint < 0) currentPoint = 0;
    if(currentPoint > points-1) currentPoint = points-1;
    x = map(currentPoint, 0,  points-1, startX, endX);
    //println(x);
    ellipse(x, h, 20, 20);
  }
  
  public boolean mOver(){
    return(dist(mouseX, mouseY, x, h) < 10); 
  }
  
}
class cGraphz {
  ArrayList<gPoint> points = new ArrayList<gPoint>();
  float posX = 0;
  float posY = 0;
  float gWidth = 100;
  float gHeight = 100;
  float maxY = 0.1f;
  float minY = 1000000;
  float pointLimit = 100;
  int iterations = 0;

  public void show() {
    rectMode(CENTER);
    fill(50);
    noStroke();
    rect(posX, posY, gWidth, gHeight);

    stroke(255);
    fill(255);
    line(posX - gWidth/2, posY + gHeight/2, posX - gWidth/2, posY - gHeight/2);
    text(maxY, posX-gWidth/2, posY-gHeight/2);
    text(minY, posX-gWidth/2, 10+posY+gHeight/2);


    line(posX - gWidth/2, posY + gHeight/2, posX + gWidth/2, posY + gHeight/2);
    text("X", posX+gWidth/2, posY+gHeight/2);

    //gPoint prevP = null;
    float px=0; 
    float py = 0;
    if (!points.isEmpty()) {

      if (iterations > 2) {
        float step = gHeight/(maxY - minY);

        //  float nUp = floor((maxY*step)/10);

        //  stroke(255);
        //  for (int i = 0; i < nUp; i++) {
        //    float yt =  (posY) - maxY*step*i;
        //    line(posX-gWidth/2, yt, posX+gWidth/2, yt);
        //  }


        float zeroY = (posY-gHeight/2) + maxY*step;
        stroke(120);
        if (zeroY > 0 && zeroY < gHeight) {
          fill(255);
          line(posX-gWidth/2, zeroY, posX+gWidth/2, zeroY);
          text("0", posX - 10 - gWidth/2, zeroY);
        }
        stroke(255);
      }

      for (int i = 0; i < points.size(); i++) {
        gPoint p = points.get(i);
        float x = (gWidth/points.size()) * i;

        if (p.y > maxY) maxY = p.y;

        //if (minSet == false){ minY = p.y; minSet = true;}
        if (p.y < minY) minY = p.y;
        if (points.size()>2) {
          float y = map(p.y, minY, maxY, 0, gHeight);


          if (i-1 > 0) {
            line((posX-gWidth/2)+x, (posY+gHeight/2)-y, (posX-gWidth/2)+px, (posY+gHeight/2)-py);
          }
          ellipse((posX - gWidth/2) + x, (posY + gHeight/2) - y, 1, 1);
          px = x;
          py = y;
        }
      }
    }
    if (pointLimit > 0 && points.size() > pointLimit) {

      for (int i = points.size()-1; i > pointLimit; i--) {
        points.remove(0);
      }
    }
    //println(maxT);
    iterations++;
  }
}

class recGraph extends cGraphz {
  recGraph(float x, float y, float w, float h) {
    posX = x;
    posY = y;
    gWidth = w;
    gHeight = h;
  }
  public void addP(float t, float x) {
    points.add(new gPoint(t, x));
  }
}

class gPoint {
  float x; 
  float y;
  gPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class state {
  boolean isStarted;
  public void Start() {
  }
  public void Update() {
  }
}


class s_playground extends state {
  body ball;
  //settingsA someButtons;
  public void Start() {
    //someButtons = new settingsA();
    //someButtons.settings.add(new bool("Авто-движение камеры (камеру можно двигать зажав правую кнопку мыши)", 10, height-20, false));
    float d = random(0, maxWindV);
    float a = random(0, TWO_PI);
    Vwind = new PVector(cos(a)*0, sin(a)*0);
    ball = new body();
  }

  public void Update() {
    ball.dT = (1/frameRate)/48;
    //camX = lerp(camX, (ball.position.x * pixelScale) - width/2, ball.dT*24*16);
    //camY = lerp(camY, (ball.position.y * pixelScale) - height/2, ball.dT*24*16);

    pushMatrix();
    translate(-camX, -camY);
    background(20);

    drawMap();
    ellipse(0, 0, 10, 10); 

    for (int i = 0; i < 48; i++)
      ball.update();

    ball.show();
    stroke(255);
    strokeWeight(1);
    line(camX, ball.groundLevel*pixelScale, camX+width, ball.groundLevel*pixelScale);
    popMatrix();

    //someButtons.show();
    
    windBallX = width-110;
    windBallY = 110;

    drawWindDirection(ball, windBallX, windBallY, true);

    info(ball);
  }
}


class s_launchSetting extends state {
  settingsA setupSettings;
  public void Start() {
    setupSettings = new settingsA();
    setupSettings.settings.add(new valueBox("Нулевой уровень:", 10, 40, "10"));
    setupSettings.settings.add(new valueBox("Начальная координата X:", 10, 90, "0"));
    setupSettings.settings.add(new valueBox("Начальная координата Y:", 10, 140, "0"));
    setupSettings.settings.add(new valueBox("Начальная скорость по X:", 10, 190, "0"));
    setupSettings.settings.add(new valueBox("Начальная скорость по Y:", 10, 240, "0"));
    setupSettings.settings.add(new valueBox("Δt:", 10, 290, "0.1"));
    setupSettings.settings.add(new button("Запустить!", 100, height-30, 200, 50));
    setupSettings.settings.add(new button("Интерактивный режим", 350, height-25, 280, 40));
  }

  public void Update() {
    background(0);
    
    if(PApplet.parseFloat(setupSettings.settings.get(5).strvalue) <= 0 && !setupSettings.settings.get(5).selected) setupSettings.settings.get(5).strvalue = "0.01";
    
    
    if (setupSettings.settings.get(setupSettings.settings.size()-2).act) {
      //review.Start();
      //review.isStarted = true;
      println("wot");
      review.ball = new body();
      review.ball.groundLevel= PApplet.parseFloat(setupSettings.settings.get(0).strvalue);
      review.ball.position.x = PApplet.parseFloat(setupSettings.settings.get(1).strvalue);
      review.ball.position.y = PApplet.parseFloat(setupSettings.settings.get(2).strvalue);
      review.ball.velocity = new PVector(PApplet.parseFloat(setupSettings.settings.get(3).strvalue), PApplet.parseFloat(setupSettings.settings.get(4).strvalue));
      review.ball.dT = PApplet.parseFloat(setupSettings.settings.get(5).strvalue);
      println(PApplet.parseFloat(setupSettings.settings.get(2).strvalue));
      println(review.ball.velocity.x);
      PROGRAM_STATE = 2;
      launchSetting.isStarted = false;
    }
    
    if(setupSettings.settings.get(setupSettings.settings.size()-1).act){
      playground.ball = new body();
      playground.ball.groundLevel= PApplet.parseFloat(setupSettings.settings.get(0).strvalue);
      playground.ball.position.x = PApplet.parseFloat(setupSettings.settings.get(1).strvalue);
      playground.ball.position.y = PApplet.parseFloat(setupSettings.settings.get(2).strvalue);
      playground.ball.velocity = new PVector(PApplet.parseFloat(setupSettings.settings.get(3).strvalue), PApplet.parseFloat(setupSettings.settings.get(4).strvalue));
      PROGRAM_STATE = 0;
      launchSetting.isStarted = false;
    }
    setupSettings.show();
  }
}


class s_review extends state {
  ArrayList<PVector> recordVelocity = new ArrayList<PVector>();
  ArrayList<PVector> recordAcceleration = new ArrayList<PVector>();
  ArrayList<PVector> recordPosition = new ArrayList<PVector>();
  //ArrayList<recGraph> graphs = new ArrayList<recGraph>();

  body ball;
  timeSlider replay;
  public void Start() {
    recordPosition.clear();
    recordVelocity.clear();
    recordAcceleration.clear();
    //graphs.clear();
    //float d = random(0, maxWindV);
    //float a = random(0, TWO_PI);
    Vwind = new PVector(0, 0);
    //ball = new body();

    //graphs.add(new recGraph((width/4), height/4, (width/2) - 30, (height/2) - 30)); // velocity Y
    //graphs.get(0).pointLimit = 800;
    //graphs.add(new recGraph(width/2 + width/4, height/4, (width/2) - 30, (height/2) - 30)); // velocity X
    //graphs.get(1).pointLimit = 800;

    while (ball.hitGround == false) {
      recordPosition.add(new PVector(ball.position.x, ball.position.y));
      recordVelocity.add(new PVector(ball.velocity.x, ball.velocity.y));
      recordAcceleration.add(new PVector(ball.acceleration.x, ball.acceleration.y));

      //println(ball.hitGround);
      ball.update();
      if (ball.lifeT > 20) break;
    }

    replay = new timeSlider();
    replay.startX = 20;
    replay.endX = width-20;
    replay.h = height-20;
    replay.points = recordPosition.size();
    //println(graphs.get(0).points.size());
  }

  public void Update() {
    background(0);



    stroke(100);
    noFill();
    beginShape();
    for (PVector p : recordPosition) {
      vertex(p.x*pixelScale, p.y*pixelScale);
    }
    endShape();

    ball.position = recordPosition.get(replay.currentPoint);
    ball.velocity = recordVelocity.get(replay.currentPoint);
    ball.acceleration = recordAcceleration.get(replay.currentPoint);


    float deltaTime = 1/frameRate;
    camX = lerp(camX, (ball.position.x * pixelScale) - width/2, deltaTime*16);
    camY = lerp(camY, (ball.position.y * pixelScale) - height/2, deltaTime*16);

    pushMatrix();
    translate(-camX, -camY);
    background(20);

    drawMap();
    ellipse(0, 0, 10, 10); 

    stroke(100);
    noFill();
    beginShape();
    for (PVector p : recordPosition) {
      vertex(p.x*pixelScale, p.y*pixelScale);
    }
    endShape();

    ball.show();
    
    stroke(255);
    strokeWeight(1);
    line(camX, ball.groundLevel*pixelScale, camX+width, ball.groundLevel*pixelScale);

    popMatrix();
      
    info(ball);
    
    //drawWindDirection(ball, width-110, 110, false);
    
    
    replay.startX = 20;
    replay.endX = width-20;
    replay.h = height-20;
    textSize(20);
    text(nfc(replay.currentPoint * ball.dT, 2) +" s", constrain(replay.x + 30, 0, width-65), replay.h - 20);
    //println(width - replay.x + 80);
    replay.show();
    //for (recGraph g : graphs) {
    //  g.show();
    //}
  }
}

float orX, orY;
public void mousePressed() {
  if (PROGRAM_STATE == 0) {
    //playground.someButtons.update();
    if (playground.ball.mouseOver() && mouseButton == LEFT) {
      playground.ball.mouseMove = true;
    }
    if (dist(mouseX, mouseY, windBallX, windBallY) < 100 && mouseButton == LEFT) {
      settingWind = true;
    }
    if (mouseButton == RIGHT) {
      orX = mouseX + camX; 
      orY = mouseY + camY;
      println(orX + " " + orY);
    }
  }
  if(PROGRAM_STATE == 2){
    if(review.replay.mOver()){
      review.replay.mousePress = true;
    }
  }
}

public void mouseDragged() {
  if (PROGRAM_STATE == 0) {
    if (mouseButton == RIGHT) {
      camX = -mouseX+orX;
      camY = -mouseY+orY;
    }
  }
}

public void mouseReleased() {
  if (PROGRAM_STATE == 0) {
    if (mouseButton == LEFT)
      playground.ball.mouseMove = false;
    settingWind = false;
  }
  if(PROGRAM_STATE == 2){
    review.replay.mousePress = false; 
  }
}

public void mouseWheel(MouseEvent event) {
  float pmx = mouseX + camX;
  float pmy = mouseY + camY;

  pixelScale -= 1/event.getCount() * 0.5f;
  if (pixelScale>80) pixelScale = 80;
  if (pixelScale<1) pixelScale = 1;

  camX += pmx - (mouseX + camX);
  camY += pmy - (mouseY + camY);
}

public void keyPressed(){
  if(PROGRAM_STATE == 1){
    launchSetting.setupSettings.update(); 
  }
  if(key == ESC && (PROGRAM_STATE == 0 || PROGRAM_STATE == 2)){
    key = 0;
    review.isStarted = false;
    PROGRAM_STATE = 1; 
    playground.isStarted = false;
  }
}
  public void settings() {  size(1200, 600, P2D);  smooth(4); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_191023a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
