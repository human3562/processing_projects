int select = 0;
void touchStarted() {
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      if (board[i][j].isMouseOver()) {
        if (board[i][j].hidden && selectedValue!=0) board[i][j].guessvalue = selectedValue;
        select = board[i][j].guessvalue;
      }
    }
  }

  for (button b : buttons) {
    if (b.isMouseOver()) {
      for (button b1 : buttons) if (b!=b1) b1.isPressed = false;
      b.isPressed = !b.isPressed;
      selectedValue = b.isPressed?byte(b.id):0;
      break;
    }
  }
  println(selectedValue);
}

void showSafes() {
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].highlighted = false;
      board[i][j].Shighlighted = false;
    }
  }
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      if (board[i][j].guessvalue == select && select!=0 && board[i][j].truevalue == board[i][j].guessvalue) {
        board[i][j].Shighlighted = true;
        for(int i1 = 0; i1<9; i1++){
          for(int j1 = 0; j1<9; j1++){
            if(board[i1][j1].boxId == board[i][j].boxId){
               board[i1][j1].highlighted = true;
            }
          }
        }
        
        for (int i1 = 0; i1<9; i1++) {
          board[i1][j].highlighted = true;
        }
        for (int j1 = 0; j1<9; j1++) {
          board[i][j1].highlighted = true;
        } 
        //board[i][j].highlighted = true;
      }
    }
  }
}
