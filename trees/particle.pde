class particle{
  float x,y;
  float stsize;
  float size;
  float a;
  float speed = 200;
  float seed = 0;
  float maxspeed = 200;
  float lifetime = 0;
  boolean dead = false;
  boolean spawned = false;
  float stime;
  
  particle(float x, float y, float a, float startSize){
    this.x = x;
    this.y = y;
    this.a = a;
    stsize = startSize;
    seed = random(-100,100);
    stime = random(0.2,0.5);
}
  
  void show(){
    //fill(255);
    noStroke();
    //stroke(255,0,0);
    size = map(speed, 0, maxspeed, 0, stsize);
    ellipse(x,y,size,size);
  }
  
  void update(){
     lifetime+=elapsedTime;
     x += speed * cos(a) * elapsedTime;
     y += speed * sin(a) * elapsedTime;
     float t = map(noise(seed),0,1,-1,1);
     speed -= 70 * elapsedTime * map(t,-1,1,0.5,1);
     a += t * 1.5 * elapsedTime;
     
     seed+=elapsedTime;
     if(speed < 0.05) dead = true;
     if(lifetime>stime && !spawned) spawn();
  }
  
  void spawn(){
    if(part.size()<2000 && speed > 1){
       part.add(new particle(x,y,a, size));
       part.add(new particle(x,y,a,size));
       dead = true;
       spawned = true;
     }
  }
}
