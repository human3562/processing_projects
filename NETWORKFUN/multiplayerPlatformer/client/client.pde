import processing.net.*;
Client client;
ArrayList<player> players = new ArrayList<player>();
String info = "";

void setup() {
  size(600, 600, P2D);
  client = new Client(this, "127.0.0.1", 5204);
  player p = new player();
  p.id = client.ip();
  frameRate(60);
}

void draw() {
  background(0);
  String[] Players = split(info, '\n');
  if(Players!=null)
  for(int i = 0; i<Players.length-1; i++){
    String pos = Players[i];
    float x = 0;
    float y = 0;
    for(int j = 0; j<pos.length(); j++){
      if(pos.charAt(j) == ' '){
        x = float(pos.substring(0,j));
        y = float(pos.substring(j));
      }
    }
    //println(x + " " + y);
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(x,y,64,64);
  }
  text("FPS: "+frameRate, 10, 10);
}

void clientEvent(Client clnt) {
  String msg = clnt.readString(); // ID X Y | ID X Y |\n
  //println(msg);
  info = msg;
}
