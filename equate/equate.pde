String sA = "";
String sB = "";
String sC = "";
double a = 0;
double b = 0;
double c = 0;
int select = -1;
void setup() {
  size(600, 800);
}

void draw() {
  background(255);
  drawStuff();
  if (!sA.isEmpty()) {
    a = float(sA);
  }
  if (!sB.isEmpty()) {
    b = float(sB);
  }
  if (!sC.isEmpty()) {
    c = float(sC);
  }
  if (a!=0) {
    double D = (b*b) - 4*a*c;
    if (D<0) {
      text("D = b - 4ac = "+D, 10, 400);
      textSize(25);
      text("2", 123, 375);
      textSize(70);
      text("ass", 10, 480);
      textSize(40);
    } else {
      text("D = b - 4ac = "+D, 10, 400);
      textSize(25);
      text("2", 123, 375);
      textSize(60);
      double x1 = (-b + Math.sqrt(D))/(2*a);
      double x2 = (-b - Math.sqrt(D))/(2*a);
      text("x = "+x1, 10, 470);
      text("x = "+x2, 10, 540);
      textSize(25);
      text("1", 45, 480);
      text("2", 45, 550);
    }
  }
}


void drawStuff() {
  textSize(60);
  textAlign(LEFT);
  fill(0);
  text("ax + bx + c = 0", 5, 100);
  textSize(35);
  text("2", 75, 65);

  textSize(40);
  rectMode(CORNERS);

  text("a = ", 10, 170);
  fill(50);
  if (select == 0) {
    strokeWeight(5);
    stroke(255, 0, 0);
  } else {
    strokeWeight(1);
    stroke(100);
  }
  rect(80, 135, width-20, 180);
  fill(255);
  textAlign(LEFT, TOP);
  text(sA, 85, 135);
  fill(0);
  textAlign(LEFT);

  text("b = ", 10, 240);
  fill(50);
  if (select == 1) {
    strokeWeight(5);
    stroke(255, 0, 0);
  } else {
    strokeWeight(1);
    stroke(100);
  }
  rect(80, 205, width-20, 250);
  fill(255);
  textAlign(LEFT, TOP);
  text(sB, 85, 205);
  fill(0);
  textAlign(LEFT);

  text("c = ", 10, 310);
  //text("b = ",10,240);
  fill(50);
  if (select == 2) {
    strokeWeight(5);
    stroke(255, 0, 0);
  } else {
    strokeWeight(1);
    stroke(100);
  }
  rect(80, 275, width-20, 320);
  fill(255);
  textAlign(LEFT, TOP);
  text(sC, 85, 275);
  fill(0);
  textAlign(LEFT);
  stroke(0);
  strokeWeight(3);
  line(0, 340, width, 340);
  strokeWeight(1);
}
