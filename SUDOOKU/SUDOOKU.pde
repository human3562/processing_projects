import java.util.Collections;
///SUDOOKU PROTOTYPE 
///IHATEPROBLEMSOLVING
///THE APP IS MOSTLY DONE, LAST THING TO DO IS TO MAKE IT ACTUALLY SOLVABLE LOL
cell[][] board = new cell[9][9];
float cellwidth = 40;
short cellspace = 0;
int[] grid;
byte selectedValue;
byte selectedCell;
button[] buttons = new button[9];

void setup() {
  //size(900, 900, P2D);
  fullScreen(P2D);
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  strokeCap(SQUARE);
  smooth(0);
  textSize(50);
  for (byte i = 0; i<9; i++) {
    for (byte j = 0; j<9; j++) {
      int x = floor(i/3);
      int y = floor(j/3);
      board[i][j] = new cell(i, j, byte(i*9+j), byte(y+x*3));
    }
  }
  generateBoard();
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].truevalue = byte(grid[i+j*9]);
    }
  }
  for (int i = 0; i<9; i++) {
    buttons[i] = new button(i+1);
  }
}

void draw() {
  cellwidth = height*0.5/9;
  textSize(cellwidth/2);
  background(255);
  strokeWeight(1);
  showSafes();
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].x = (((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*j)+cellwidth/2;
      board[i][j].y = ((height-((cellwidth+cellspace)*9))/2  + (cellwidth+cellspace)*i)+cellwidth/2;
      if (!board[i][j].Shighlighted)
        fill(board[i][j].highlighted?200:255);
      else fill(0, 0, 100, 100);
      rect(board[i][j].x, board[i][j].y, cellwidth, cellwidth);
      if (!board[i][j].hidden) {
        fill(0);
        board[i][j].guessvalue = board[i][j].truevalue;
        text(board[i][j].truevalue, board[i][j].x, board[i][j].y);
      } else {
        if (board[i][j].guessvalue!=0) {
          fill((board[i][j].truevalue==board[i][j].guessvalue?color(0, 0, 255):color(255, 0, 0)));
          text(board[i][j].guessvalue, board[i][j].x, board[i][j].y);
        }
      }
    }
  }


  //stroke(255,0,0);
  //line(width/2,0,width/2,height);
  //line(0,height/2,width,height/2);

  //purely for the looks. will finish this later!
  strokeWeight(3);

  float lx1 = ((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*3;
  float lx2 = ((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*6;
  float ly1 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2);
  float ly2 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2) - (cellwidth+cellspace)*8;
  line(lx1, ly1+cellwidth/2, lx1, ly2-cellwidth/2);
  line(lx2, ly1+cellwidth/2, lx2, ly2-cellwidth/2);

  float ly = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2)-(cellwidth+cellspace)*3;
  float ly3 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2)-(cellwidth+cellspace)*6;
  float lx11 = (((width-(cellwidth+cellspace)*9)/2));
  float lx22 = (((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*9);
  line(lx11, ly+cellwidth/2, lx22, ly+cellwidth/2);
  line(lx11, ly3+cellwidth/2, lx22, ly3+cellwidth/2);

  for (int i = 0; i<9; i++) {
    buttons[i].x =  (((width-(buttons[i].w)*buttons.length)/2) + (buttons[i].w)*i)+buttons[i].w/2;
    buttons[i].y = height - buttons[i].w - 5;
    buttons[i].show();
  }
  textSize(12);
  text(selectedValue, 10, 15);
  text(selectedCell, 10, 15*2);
}
