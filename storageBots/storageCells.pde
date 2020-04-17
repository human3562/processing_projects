ArrayList<sCell> storageGrid = new ArrayList<sCell>();
class sCell {
  int idX, idY;
  int amt;
  int maxCap = 20;
  object storageObj = null;
  sCell(int x, int y) {
    idX = x; 
    idY = y;
  }
  
  void putObj(object obj, int amount){
    storageObj = obj;
    amt = amount;
  }
}
