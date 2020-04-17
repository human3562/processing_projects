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

  float R = 0.25; //radius
  float h = 0;

  boolean showVectors = true;
  boolean mouseMove = false;

  float dT = 0.1;
  
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

  void update() {

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
      velocity = PVector.div( PVector.add(velocity, new PVector(mx/2, my/2)), 1.001);
    }

    if (hBound != 0 && wBound != 0) {
      if (position.x+velocity.x*dT > wBound-R) {
        position.x = wBound-R;
        velocity.x *= -0.8;
      }
      if (position.x+velocity.x*dT < -wBound+R) {
        position.x = -wBound+R;
        velocity.x *= -0.8;
      }
      if (position.y+velocity.y*dT > hBound-R) {
        position.y = hBound-R;
        velocity.y *= -0.8;
      }
      if (position.y+velocity.y*dT < -hBound+R) {
        position.y = -hBound+R;
        velocity.y *= -0.8;
      }
    } else {
      if (position.y+velocity.y*dT > groundLevel-R) {
        position.y = groundLevel-R;
        velocity.y *= -0.8;
        hitGround = true;
      }
    }

    position = PVector.add(position, PVector.mult(velocity, dT));
    lifeT += dT;
  }

  void show() {
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

  void drawVectors() {
    strokeWeight(1);
    stroke(255, 0, 0);
    line((position.x * pixelScale) - width/2, (position.y * pixelScale) - height/2, ((position.x * pixelScale) + velocity.x * pixelScale) - width/2, ((position.y* pixelScale)+velocity.y*pixelScale) - height/2);
    stroke(0, 255, 0);
    line((position.x * pixelScale) - width/2, (position.y * pixelScale) - height/2, ((position.x*pixelScale)+acceleration.x*pixelScale) - width/2, ((position.y*pixelScale)+acceleration.y*pixelScale) - height/2);
  }

  boolean mouseOver() {
    //if (mouseX-width/2>-wBound*pixelScale && mouseX-width/2<wBound*pixelScale && mouseY-height/2>-hBound*pixelScale && mouseY-height/2<hBound*pixelScale) {
    float mX = (mouseX+camX)/pixelScale;
    float mY = (mouseY+camY)/pixelScale;
    return(dist(position.x, position.y, mX, mY)<R);
    //} else return false;
  }
}
