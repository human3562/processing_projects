import processing.net.*;
Client client;
String typing = "";
String name = "ss";
String chatLog = "";
String state = "SETUP";
float scroll = 0;

void setup(){
  size(600,600);
  client = new Client(this, "25.83.99.6", 5204);
  frameRate(30);
}

void draw(){
  background(100); 
  if(state == "SETUP"){
    textSize(24);
    textAlign(CENTER);
    text("Please enter your name. (Press ENTER to continue)",width/2, 50);
    text(typing, width/2, 100);
    strokeWeight(1);
    stroke(0);
    line(width/2-100,103,width/2+100,103);
  }
  if(state == "CHAT"){
    fill(255);
    textSize(24);
    textAlign(LEFT,UP);
    text(chatLog,10,15+scroll,580,20000);
    rectMode(CORNERS);
    fill(0);
    rect(0,height-30,width,height);
    fill(255);
    text(typing,0,height-5);
  }
}

void clientEvent(Client clnt){
  String msg = clnt.readString();
  if(msg!=null){
    chatLog += msg;
    println(msg);
  }
}
