ArrayList<cell> board = new ArrayList<cell>();
ArrayList<cell> enemyBoard = new ArrayList<cell>();
void setup() {
  size(1200, 600);
  float cOffset = ((width/2) - ((cWidth) + cWidth * 9))/2;
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      float x = ((cWidth/2) + cWidth * i) + cOffset;
      float y = ((cWidth/2) + cWidth * j) + cOffset;
      int id = i+j*9;
      board.add(new cell(x, y, id));
    }
  }
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      float x = ((cWidth/2) + cWidth * i) + cOffset + width/2;
      float y = ((cWidth/2) + cWidth * j) + cOffset;
      int id = i+j*9;
      board.add(new cell(x, y, id, true));
    }
  }
}

void draw() {
  background(255);
  stroke(0);
  line(width/2, 0, width/2, height);
  if (!board.isEmpty())
    for (cell c : board) {
      c.show();
    }
  if (!enemyBoard.isEmpty())
    for (cell c : enemyBoard) {
      c.show();
    }
}
