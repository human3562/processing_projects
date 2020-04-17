
ArrayList<recGraph> graphs = new ArrayList<recGraph>();
float elapsedTime = 0;
float t = 0;
void setup() {
  size(600, 600);
  graphs.add(new recGraph(width/4, height/4, (width/2) - 30, (height/2) - 30));
  graphs.add(new recGraph(width/2 + width/4, height/4, (width/2) - 30, (height/2) - 30));
  graphs.add(new recGraph(width/4, height/2 + height/4, (width/2) - 30, (height/2) - 30));
  graphs.add(new recGraph(width/2 + width/4, height/2 + height/4, (width/2) - 30, (height/2) - 30));
  graphs.get(1).pointLimit = 200;
  graphs.get(0).pointLimit = 800;
}

void draw() {
  elapsedTime = 1/frameRate;
  background(0);
  for (recGraph g : graphs) {
    g.show();
  }
  physics();
  if (frameCount % 1 == 0) {
      t+=elapsedTime*1;
      //println(noise(t));
      graphs.get(0).addP(elapsedTime, h);
      graphs.get(1).addP(elapsedTime, V);
      //graphs.get(2).addP(elapsedTime, noise(t+100));
      //graphs.get(3).addP(elapsedTime, abs(sin(t) + map(noise(t),0,1,-0.1,0.1)));
    }
}
float V = 0;
float h = 10;
float m = 1;
float G = 9.8;
void physics(){
  V -= m * G;
  if(up) V += 10;
  h += V * elapsedTime;
  if(h < 0){
    h = 0;
    V *= -0.8;
  }
}
