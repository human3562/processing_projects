import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class customclient extends PApplet {


Client client;
String typing = "";
String name = "ss";
String chatLog = "";
String state = "SETUP";
float scroll = 0;

public void setup(){
  
  client = new Client(this, "25.83.99.6", 5204);
  frameRate(30);
}

public void draw(){
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

public void clientEvent(Client clnt){
  String msg = clnt.readString();
  if(msg!=null){
    chatLog += msg;
    println(msg);
  }
}
public void keyPressed() {
  if (key == ESC){
    key = 0;
    client.write("announce "+name+" вышел.\n");
    delay(1000);
    exit();
    return;
  }
  if (key == BACKSPACE) {
    if (typing.length()>0)
      typing = typing.substring(0, typing.length()-1);
  } else if ((keyCode != ENTER && keyCode != RETURN && keyCode != SHIFT && key != TAB && keyCode!=CONTROL && keyCode!=ALT) && typing.length()<600) {
    typing += key;
  }
  if((keyCode == ENTER || keyCode == RETURN) && typing.length()>0){
    if(state == "SETUP"){
      name = typing;
      typing = "";
      state = "CHAT";
      client.write("announce "+name+" вошел в чат.\n");
    }else if(state == "CHAT"){
      String msg = "";
      msg = name.trim()+" says "+typing;
      typing = "";
      client.write(msg+"\n");
    }
  }
}

public void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  scroll+=e*8;
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "customclient" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
