ArrayList<aBody> bodies = new ArrayList<aBody>();
float G_CONSTANT = 6.67408;
class aBody {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float diameter;

  aBody(float x, float y, float d, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    diameter = d;
    mass = m;
  }

  void update() {
    ArrayList<PVector> forces = new ArrayList<PVector>();
    for (aBody target : bodies) {
      if (target == this) continue;
      float a = atan2(target.position.y-position.y, target.position.x-position.x);
      float m = mass * target.mass;
      float r = PVector.dist(position, target.position)*PVector.dist(position, target.position);
      float F = G_CONSTANT * (m/r);
      forces.add(new PVector(F*cos(a),F*sin(a)));
      //target.acceleration.x += -(F/target.mass)*cos(a);
      //target.acceleration.y += -(F/target.mass)*sin(a);
      
      //println(F);
      stroke(255, 0, 0);
      line(position.x, position.y, position.x + acceleration.x, position.y + acceleration.y);
      line(target.position.x, target.position.y, target.position.x + target.acceleration.x, target.position.y + target.acceleration.y);
      
      if (overlap(this, target)) {
        float d = PVector.dist(position, target.position);
        float overlap = 0.5 * (d - diameter/2 - target.diameter/2);
        position.x -= overlap * (position.x - target.position.x) / d;
        position.y -= overlap * (position.y - target.position.y) / d;
        target.position.x += overlap * (position.x - target.position.x) / d;
        target.position.y += overlap * (position.y - target.position.y) / d;
        dynamicCollision(this, target);
      }
      if(position.x > width){ position.x = width; velocity.x = -velocity.x;}
      if(position.x < 0){ position.x = 0; velocity.x = -velocity.x;}
      if(position.y > height){position.y = height; velocity.y = -velocity.y;}
      if(position.y < 0){position.y = 0; velocity.y = -velocity.y;}
      
    }
    //println(forces.size());
    PVector force = new PVector(0,0);
    if(!forces.isEmpty()){
      for(PVector p : forces){
         force.add(p);
      }
    }
    acceleration = force.div(mass);
    
    velocity.x += acceleration.x * elapsedTime;
    velocity.y += acceleration.y * elapsedTime;
    velocity.limit(1000);
    position.x += velocity.x * elapsedTime;
    position.y += velocity.y * elapsedTime;
  }

  void show() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, diameter, diameter);
  }
}


void physics() {
  for (aBody b : bodies) {
    b.update();
  }
}


void dynamicCollision(aBody b1, aBody b2) {
  float distance = PVector.dist(b1.position, b2.position);

  float nx = (b2.position.x - b1.position.x)/distance;
  float ny = (b2.position.y - b1.position.y)/distance;

  float tx = -ny;
  float ty = nx;

  float dpTan1 = b1.velocity.x*tx + b1.velocity.y*ty;
  float dpTan2 = b2.velocity.x*tx + b2.velocity.y*ty; 

  float dpNorm1 = b1.velocity.x * nx + b1.velocity.y * ny;
  float dpNorm2 = b2.velocity.x * nx + b2.velocity.y * ny;

  float m1 = (dpNorm1 * (b1.mass - b2.mass) + 2 * b2.mass * dpNorm2) / (b1.mass + b2.mass);
  float m2 = (dpNorm2 * (b2.mass - b1.mass) + 2 * b1.mass * dpNorm1) / (b1.mass + b2.mass);

  b1.velocity.x = (tx * dpTan1 + nx * m1);
  b1.velocity.y = (ty * dpTan1 + ny * m1);
  b2.velocity.x = (tx * dpTan2 + nx * m2);
  b2.velocity.y = (ty * dpTan2 + ny * m2);
}

boolean overlap(aBody b1, aBody b2) {
  float d = (b1.diameter/2) + (b2.diameter/2);
  if (PVector.dist(b1.position, b2.position) < d) {
    return true;
  }
  return false;
}
