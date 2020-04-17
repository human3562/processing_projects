class object {
  String name;
  float price;
  color c;
}
//here go the subclasses to the object class, i.e like a bag of chips will derive from the object class
class dummy extends object {

  dummy() {
    name = "dummy";
    price = 100;
    c = color(255, 0, 0);
  }
}

class apple extends object {
  apple(){
    name = "apple";
    price = 10;
    c = color(0,255,0);
  }
}

class rice extends object {
  rice(){
    name = "rice";
    price = 20;
    c = color(100,100,100);
  }
}
