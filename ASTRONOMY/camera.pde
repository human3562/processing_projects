boolean up,down,left,right;
float offsetX, offsetY;
float zoom = 1;
float camSpeed = 10;
boolean mwheel = true;
void cUpdate() {
  if (left) offsetX -= camSpeed;
  if (right) offsetX += camSpeed;
  if (up) offsetY -= camSpeed;
  if (down) offsetY += camSpeed;
}
