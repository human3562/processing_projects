import processing.net.*;

Server server;

String inMessage = "";

void setup(){
  //size(400,200);
  surface.setVisible(false);
  server = new Server(this,5204);
  frameRate(10);
  println("Server set up.");
  //String a = "iam ian";
  //println(a.substring(0,3));
}

void draw(){
  Client client = server.available();
  
  if(client != null){
    inMessage = client.readStringUntil('\n');
    inMessage = inMessage.trim();
    println("Got message from client '"+client.ip()+"': "+inMessage);
    //(name) says "message"
    if(inMessage.contains("says")){
      String name = "";
      String msg = "";
      for(int i = 0; i<inMessage.length(); i++){
        if(inMessage.charAt(i) == ' '){
           name = inMessage.substring(0,i);
           msg = inMessage.substring(i+6,inMessage.length());
           break;
        }
      }
      server.write(name+": "+msg+"\n");
    }else if(inMessage.contains("announce")){
      String msg = "";
      msg = inMessage.substring(9,inMessage.length());
      server.write(msg+"\n");
    }
  }
}

void serverEvent(Server serv, Client clnt){
  println("New client connected: '"+clnt.ip()+"'"); 
  //chatLog += clnt.ip()+" connected\n";
}
