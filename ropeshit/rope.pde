class rope {
  ArrayList<ropeVert> ropeverts = new ArrayList<ropeVert>();
  float originX, originY;
  float targetX, targetY;
  float len;
  float offset = 0.1;
  rope(float _originX, float _originY) {
    originX = _originX;
    originY = _originY;
    ropeVert mouse = new ropeVert(mouseX, mouseY, -1);
    ropeverts.add(new ropeVert(originX, originY, 0));
    ropeverts.add(mouse);
  }

  void update() {
    //clearVerts();
    //len = dist(originX, originY, mouseX, mouseY);
    //SEEK FOR INTERSECTION POINTS
    for(Shape s : shapes)
    for(int i = 0; i<2; i++)
    resolve(s);
    //ropeverts.remove(mouse);
    //ropeverts.add(mouse);
    //RESOLVE POINTS
    //ADD POINT TO ARRAY
  }

  boolean collides(ropeVert p1, ropeVert p2, Shape s) {
    PVector[] vertices = new PVector[4];
    for (int i = 0; i<4; i++) {
      vertices[i] = new PVector(s.verts[i].x, s.verts[i].y);
    }
    PVector P1 = new PVector(p1.x, p1.y);
    PVector P2 = new PVector(p2.x, p2.y);
    float d = PVector.dist(P1, P2);

    for (int i = 0; i<ceil(d); i++) {
      PVector l = PVector.lerp(P1, P2, i/d);
      //ellipse(l.x, l.y, 4, 4);
      //Rprintln(i/d);
      if (l.x >= s.x+offset && l.x <= s.x+s.w-offset && l.y >= s.y+offset && l.y <=s.y+s.h-offset) {
        return true;
      }
    }

    return false;
  }

  ropeVert getColPoint(ropeVert p1, ropeVert p2, Shape s) {
    PVector[] vertices = new PVector[4];
    for (int i = 0; i<4; i++) {
      vertices[i] = new PVector(s.verts[i].x, s.verts[i].y);
    }
    PVector P1 = new PVector(p1.x, p1.y);
    PVector P2 = new PVector(p2.x, p2.y);
    float d = PVector.dist(P1, P2);

    for (int i = 0; i<ceil(d); i++) {
      PVector l = PVector.lerp(P1, P2, i/d);
      PVector nextl = PVector.lerp(P1,P2,(i+1)/d);
      //Rprintln(i/d);
      //ellipse(l.x, l.y, 4, 4);
      if (boxCol(l,s.x,s.y,s.w,s.h,offset) && !boxCol(nextl,s.x,s.y,s.w,s.h,offset)) {
        //ropeVert r = new ropeVert(l.x, l.y, -1);
        float[] distances = new float[4];
        for (int j = 0; j<4; j++) {
          distances[j] = PVector.dist(l, vertices[j]);
        }
        for (int j = 0; j<4; j++) {
          if (distances[j]<distances[(j+1)%4] && distances[j]<distances[(j+2)%4] && distances[j]<distances[(j+3)%4]) {
            return new ropeVert(s.verts[j].x, s.verts[j].y, ropeverts.size());
          }
        }
      }
    }
    return s.verts[1];
  }
  
  boolean boxCol(PVector p, float x, float y, float w, float h, float offset){
    return (p.x >= x+offset && p.x <= x+w-offset && p.y >= y+offset && p.y <=y+h-offset);
  }

  void resolve(Shape s) {
    
    PVector[] shapeVerts = new PVector[4];
    for (int i = 0; i<4; i++) {
      shapeVerts[i] = new PVector(s.verts[i].x, s.verts[i].y);
    }
    //PVector target = new PVector(mouseX, mouseY);
    if (!ropeverts.isEmpty()) {
      //println(ropeverts.size());
      //boolean ay = false;

      //for (int i = 0; i<ropeverts.size()-1; i++) {
      //if (ropeverts.get(i+1).) {
      if (collides(ropeverts.get(ropeverts.size()-2), ropeverts.get(ropeverts.size()-1), s)) {
        //add point to line vertices
        //ropeVert temp = ropeverts.get(ropeverts.size()-1);
        //addClosest(getColPoint(ropeverts.get(ropeverts.size()-2), ropeverts.get(ropeverts.size()-1), s), s);
        //ropeverts.remove(temp);
        //println(getColPoint(ropeverts.get(ropeverts.size()-2), ropeverts.get(ropeverts.size()-1), s).x);
        ropeVert r = getColPoint(ropeverts.get(ropeverts.size()-2), ropeverts.get(ropeverts.size()-1), s);
        //if (!ropeverts.contains(r))
          ropeverts.add(r);
        //ropeverts.add(getColPoint(ropeverts.get(ropeverts.size()-2), ropeverts.get(ropeverts.size()-1),s));
        //println(i);
        //ay = true;
        //println("yo i need to add a line wow");
        //} else continue;
        //}
      }

      ropeVert mouse = new ropeVert(mouseX, mouseY, -5);
      for (ropeVert r : ropeverts) {
        if (r.id == -5) {
          ropeverts.remove(r); 
          break;
        }
      }
      ropeverts.add(mouse);

      for (int i = 0; i<ropeverts.size()-2; i++) {
      //if (ropeverts.get()!=null) {
      if (ropeverts.size()>2) {
        if (!collides(ropeverts.get(i), ropeverts.get(i+2), s)) {
          ropeverts.remove(ropeverts.get(i+1));
          //print("ay");
        } //else continue;
      }
      //} //else break;
      }
    }
  }


  void show() {
    if (!ropeverts.isEmpty()) {
      stroke(0);
      strokeWeight(4);
      noFill();
      beginShape();
      for (int i = 0; i<ropeverts.size(); i++) {
        vertex(ropeverts.get(i).x, ropeverts.get(i).y);
      }
      endShape();
    }
  }

  void clearVerts() {
    if (!ropeverts.isEmpty()) {
      for (int i = ropeverts.size()-1; i>=0; i--) {
        ropeverts.remove(ropeverts.get(i));
      }
    }
  }
}

class ropeVert {
  float x, y;
  float id;

  ropeVert(float _x, float _y, float _id) {
    x = _x; 
    y = _y; 
    id = _id;
  }

  void show() {
    fill(255, 0, 0);
    ellipse(x, y, 4, 4);
  }
}
