ArrayList<particle> part = new ArrayList<particle>();
float elapsedTime = 0;
float t;
void setup() {
  //fullScreen();
  size(1200,600);
  part.add(new particle(0, height/2, 0, 10));
  background(0);
  frameRate(220);
}
void draw() {
  elapsedTime = 1/frameRate;
  t+=elapsedTime;
  fill(255);
  fill(noise(t+1000)*255,noise(t-1000)*255,noise(t+2000)*255);
  for (int i = 0; i<part.size(); i++) {
    part.get(i).update();
    part.get(i).show();
  }

  for (int i = part.size() - 1; i >= 0; i--) {
    particle p = part.get(i);
    if (p.dead) {
      part.remove(i);
    }
  }
  if(space) restart();
  println(part.size());
}

void restart() {
  for(int i = 0; i<part.size(); i++){
    part.remove(i); 
  }
  part.add(new particle(width/2, height, -PI/2, 5));
  background(0);
}
