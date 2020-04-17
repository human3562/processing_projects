import processing.net.*;

Server server;

ArrayList<player> players = new ArrayList<player>();
float elapsedTime = 0;

void setup() {
  size(600, 600);
  surface.setVisible(false);
  server = new Server(this, 5204);
  frameRate(60);
  players.add(new player("0"));
}

void draw() {
  elapsedTime = 1/frameRate;
  background(0);

  Client client = server.available();
  if (client != null) {
    String inMessage = client.readStringUntil('\n');
    inMessage = inMessage.trim();
    println(inMessage);
    player P = getPlayer(client.ip());
    if (inMessage.contains("UP")) {
      if (inMessage.contains("!")) {
        P.up = false;
      } else {
        P.up = true;
      }
    }
    if (inMessage.contains("DOWN")) {
      if (inMessage.contains("!")) {
        P.down = false;
      } else {
        P.down = true;
      }
    }
    if (inMessage.contains("LEFT")) {
      if (inMessage.contains("!")) {
        P.left = false;
      } else {
        P.left = true;
      }
    }
    if (inMessage.contains("RIGHT")) {
      if (inMessage.contains("!")) {
        P.right = false;
      } else {
        P.right = true;
      }
    }
    if(inMessage.contains("SPACEBAR")){
      P.speedY = -500; 
    }
  }
  if (!players.isEmpty())
    for (player p : players) {
      p.update();
      //p.show();
    }

  if (!players.isEmpty()) {
    String msg = "";
    for(player p : players){
      msg += p.positionX + " " + p.positionY + "\n";
    }
    server.write(msg);
  }
}

void serverEvent(Server serv, Client clnt) {
  println("New client connected: '"+clnt.ip()+"'"); 
  players.add(new player(clnt.ip()));
}

player getPlayer(String ip) {
  for (player p : players) {
    if (p.IP.contains(ip)) 
      return p;
  }
  return null;
}
