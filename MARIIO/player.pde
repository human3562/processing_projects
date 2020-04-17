class Player {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  boolean up, right, left, down;
  boolean canJump = true;
  boolean onGround = false;
  //boolean noInput = false;
  float maxSpeed = 8;
  //int cnt = 0;
  void update() {
    //vel.x = 0;
    //vel.y = 0;
    //noInput = false;
    //down = false;
    //cnt = 0;
    if (up) {
      vel.y = -6;
      //cnt++;
    }
    if (down) {
      if (onGround)
        vel.y = 6;
      //cnt++;
    }
    if (left) {
      vel.x += (onGround ? -80 : -10) * deltaTime; 
      //cnt++;
    }
    if (right) {
      vel.x += (onGround ? 80 : 10) * deltaTime; 
      //cnt++;
    }
    //if(cnt == 0) noInput = true;
    vel.y += 30 * deltaTime;

    if (onGround) {
      vel.x += -7 * vel.x * deltaTime;
    }

    if (abs(vel.x) < 0.01) {
      vel.x = 0;
    }

    float newPosX = pos.x + vel.x * deltaTime;
    float newPosY = pos.y + vel.y * deltaTime;

    if (vel.x > maxSpeed) vel.x = maxSpeed;
    if (vel.x < -maxSpeed) vel.x = -maxSpeed;
    if (vel.y > 100) vel.y = 100;
    if (vel.y < -100) vel.y = -100;

    if (vel.x <= 0) {
      if (tiles.get(GetTile(int(newPosX + 0), int(pos.y + 0))).ch!='.' || tiles.get(GetTile(int(newPosX + 0), int(pos.y + 0.9))).ch != '.') {
        newPosX = int(newPosX) + 1;
        vel.x = 0;
      }
    } else {
      if (tiles.get(GetTile(int(newPosX + 1), int( pos.y + 0))).ch!='.' || tiles.get(GetTile(int(newPosX + 1), int( pos.y + 0.9))).ch != '.') {
        newPosX = int(newPosX);
        vel.x = 0;
      }
    }
    onGround = false;
    if (vel.y <= 0) {
      if (tiles.get(GetTile(int(newPosX + 0), int(newPosY))).ch!='.' || tiles.get(GetTile(int(newPosX + 0.9), int(newPosY))).ch != '.') {
        if (tiles.get(GetTile(int(newPosX + 0), int(newPosY))).ch!='.' && vel.y > -11 && vel.y < -2) {
          tiles.get(GetTile(int(newPosX + 0), int(newPosY))).hit();
        }
        if (tiles.get(GetTile(int(newPosX + 0.9), int(newPosY))).ch != '.' && vel.y > -11 && vel.y < -2) {
          tiles.get(GetTile(int(newPosX + 0.9), int(newPosY))).hit();
        }
        newPosY = int(newPosY) + 1;
        vel.y = 0;
      }
    } else {
      if (tiles.get(GetTile(int(newPosX + 0), int(newPosY + 1))).ch!='.' || tiles.get(GetTile(int(newPosX + 0.9), int(newPosY + 1))).ch != '.') {
        newPosY = int(newPosY);
        //print("omg");
        vel.y = 0;
        canJump = true;
        onGround = true;
      }
    }

    pos.x = newPosX;
    pos.y = newPosY;

    if (pos.x<0)
      pos.x = 0;
    if (pos.x>(level.Width-1))
      pos.x = (level.Width-1);
    //if(pos.y<0)
    //pos.y = 0;
  }
}
