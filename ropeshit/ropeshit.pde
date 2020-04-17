rope R;
ArrayList<Shape> shapes = new ArrayList<Shape>();
Shape testShape;
color col = color(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
void setup(){
  size(600,600);
  //fullScreen();
  frameRate(60);
  R = new rope(width/2, height/2);
  shapes.add(new Shape(200,400,200,100));
  //shapes.add(new Shape(700,height-300,width/2-600,100));
}

void draw(){
  background(col);
  fill(0);
  ellipse(width/2, height/2, 20, 20);
  for(Shape s : shapes)    
  s.show();
  R.update();
  R.show();
  fill(0);
  text("FPS: "+frameRate,10,10);
  text("ropeverts size: "+R.ropeverts.size(), 10, 25);
}
