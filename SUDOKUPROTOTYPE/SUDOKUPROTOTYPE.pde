import java.util.Collections;
///SUDOOKU PROTOTYPE 
///IHATEPROBLEMSOLVING

cell[][] board = new cell[9][9];
float cellwidth = 40;
short cellspace = 0;
int[] grid;
byte selectedValue;
byte selectedCell;
button[] buttons = new button[9];

void setup() {
  size(900, 900, P2D);
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  strokeCap(SQUARE);
  smooth(0);
  //frameRate(60);
  //surface.setResizable(true);
  textSize(50);
  for (byte i = 0; i<9; i++) {
    for (byte j = 0; j<9; j++) {
      int x = floor(i/3);
      int y = floor(j/3);
      board[i][j] = new cell(i, j, byte(i+j*9), byte(y+x*3));
    }
  }
  generateBoard();
  for(int i = 0; i<9; i++){
    buttons[i] = new button(i+1); 
  }
}
byte gen = 0;

void draw() {
  if(gen<2){
    hideCells();
    gen++;
  }
  cellwidth = height*0.5/9;
  textSize(cellwidth/2);
  background(255);
  strokeWeight(1);
  showSafes();
  //println(board[0][1].id);
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].y = (((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*j)+cellwidth/2;
      board[i][j].x = ((height-((cellwidth+cellspace)*9))/2  + (cellwidth+cellspace)*i)+cellwidth/2;
      fill(board[i][j].highlighted?200:255);
      rect(board[i][j].x,board[i][j].y, cellwidth, cellwidth);
      if (!board[i][j].hidden) {
        fill(0);
        board[i][j].guessvalue = board[i][j].truevalue;
        text(board[i][j].truevalue, board[i][j].x, board[i][j].y);
      }else{
        if(board[i][j].guessvalue!=0){
          fill((board[i][j].truevalue==board[i][j].guessvalue?color(0,0,255):color(255,0,0)));
          text(board[i][j].guessvalue, board[i][j].x, board[i][j].y);
        }
      }
    }
  }
  //stepSolver();
  

  //stroke(255,0,0);
  //line(width/2,0,width/2,height);
  //line(0,height/2,width,height/2);

  strokeWeight(3);

  float lx1 = ((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*3;
  float lx2 = ((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*6;
  float ly1 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2);
  float ly2 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2) - (cellwidth+cellspace)*8;
  line(lx1,ly1+cellwidth/2,lx1,ly2-cellwidth/2);
  line(lx2,ly1+cellwidth/2,lx2,ly2-cellwidth/2);
  
  float ly = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2)-(cellwidth+cellspace)*3;
  float ly3 = ((((cellwidth+cellspace)*9) + height-(cellwidth+cellspace*9))/2)-(cellwidth+cellspace)*6;
  float lx11 = (((width-(cellwidth+cellspace)*9)/2));
  float lx22 = (((width-(cellwidth+cellspace)*9)/2) + (cellwidth+cellspace)*9);
  line(lx11,ly+cellwidth/2,lx22,ly+cellwidth/2);
  line(lx11,ly3+cellwidth/2,lx22,ly3+cellwidth/2);
  
  for(int i = 0; i<9; i++){
    buttons[i].x =  (((width-(buttons[i].w)*buttons.length)/2) + (buttons[i].w)*i)+buttons[i].w/2;
    buttons[i].y = height - buttons[i].w - 5;
    buttons[i].show();
  }
  textSize(12);
  text(selectedValue,10,15);
  text(selectedCell,10,15*2);
  
}
