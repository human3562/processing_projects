class cell {
  float x, y;
  byte id;
  byte truevalue;
  byte boxId;
  byte i, j;
  boolean hidden = false;
  byte guessvalue;
  boolean highlighted = false;

  boolean isMouseOver() {
    return(mouseX>x-cellwidth/2&&mouseX<x+cellwidth/2&&mouseY>y-cellwidth/2&&mouseY<y+cellwidth/2);
  }

  cell(byte _i, byte _j, byte _id, byte _boxId) {
    id = _id;
    boxId = _boxId;
    i = _i;
    j = _j;
    //truevalue = byte(random(1,9));
  }
}

void generateBoard() {
  grid = generateGrid();
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].truevalue = byte(grid[i+j*9]);
    }
  }
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      solveCell c = new solveCell(board[i][j].id);
      if (!board[i][j].hidden) c.finalValue = board[i][j].truevalue;
      solving.add(c);
    }
  }
}

void hideCells() {
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      board[i][j].hidden = false;
    }
  }
  for (int i = 0; i<70; i++) {
    int x = floor(random(0, 9));
    int y = floor(random(0, 9));
    board[x][y].hidden = true;
    if (!isSolvable(board)) {
      board[x][y].hidden = false;
    }
  }

  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      if (board[i][j].hidden) {
        board[i][j].guessvalue = 0;
      }
    }
  }
}

class solveCell {
  int id;
  ArrayList<Integer> guessValues = new ArrayList<Integer>();
  int finalValue = 0;
  solveCell(int _id) {
    id = _id;
  }
}

ArrayList<solveCell> solving = new ArrayList<solveCell>();
int currentsolve = 0;

boolean isSolvable(cell[][] boardd) {
  cell[][] b = new cell[9][9];
  b=boardd;
  for (int i = 0; i<9; i++) {
    for (int j = 0; j<9; j++) {
      b[i][j] = boardd[i][j];
    }
  }
  boolean fail = false;
  boolean done = true;
  int f = 0;
  while (fail == false || done == false) {
    done = true;
    for (int i = 0; i<9; i++) {
      for (int j = 0; j<9; j++) {
        if (b[i][j].guessvalue == 0) {
          done = false;
        }
      }
    }
    if (done) return true;
    cell[][] snap = b;
    stepSolver(b);
    if (b == snap) {
      f++;
    }
    if (f>10) return false;
    if (done) return true;
  }
  return false;
}

void stepSolver(cell[][] boardd) {
  for (int o = 1; o<10; o++) {
    ArrayList<cell> freeCells = new ArrayList<cell>();
    for (int i = 0; i<9; i++) {
      for (int j = 0; j<9; j++) {
        boardd[i][j].highlighted = false;
      }
    }
    for (int i = 0; i<9; i++) {
      for (int j = 0; j<9; j++) {
        if (boardd[i][j].guessvalue == o) {
          for (int i1 = 0; i1<9; i1++) {
            for (int j1 = 0; j1<9; j1++) {
              if (boardd[i1][j1].boxId == boardd[i][j].boxId || boardd[i1][j1].guessvalue!=0) {
                boardd[i1][j1].highlighted = true;
              }
            }
          }

          for (int i1 = 0; i1<9; i1++) {
            boardd[i1][j].highlighted = true;
          }
          for (int j1 = 0; j1<9; j1++) {
            boardd[i][j1].highlighted = true;
          }
        }
      }
    }
    for (int i1 = 0; i1<9; i1++) {
      for (int j1 = 0; j1<9; j1++) {
        if (boardd[i1][j1].highlighted == false) {
          freeCells.add(boardd[i1][j1]);
        }
      }
    }
    for (int b = 0; b<9; b++) {
      int clear = 0;
      for (cell c : freeCells) {
        if (c.boxId == b) {
          clear++;
        }
      }
      if (clear == 1) {
        for (cell c : freeCells) {
          if (c.boxId == b) {
            println("did it!");
            boardd[c.i][c.j].guessvalue = byte(o);
          }
        }
      }
    }
  }
}

//boolean isSafe(cell c) {
//  //println(checkCol(c) + " " + checkRow(c) + " " + checkBox(c));
//  return(checkCol(c) && checkRow(c) && checkBox(c));
//}

//boolean checkCol(cell c) {
//  for (int i = 0; i<9; i++) {
//    if (boardd[i][c.j].guessvalue == 0) continue;
//    if (boardd[i][c.j].guessvalue == c.guessvalue) return false;
//  }
//  return true;
//}

//boolean checkRow(cell c) {
//  for (int i = 0; i<9; i++) {
//    if (board[c.i][i].guessvalue == 0) continue;
//    if (board[c.i][i].guessvalue == c.guessvalue) return false;
//  }
//  return true;
//}

//boolean checkBox(cell c) {
//  for (int i = 0; i<9; i++) {
//    for (int j = 0; j<9; j++) {
//      if (board[i][j].boxId == c.boxId) {
//        if (board[i][j].guessvalue == c.guessvalue) {
//          return false;
//        }
//      }
//    }
//  } 
//  return true;
//}

int[] generateGrid()
{
  ArrayList<Integer> arr = new ArrayList<Integer>(9);
  grid = new int[81];
  for (int i = 1; i <= 9; i++) arr.add(i);

  //loads all boxes with numbers 1 through 9
  for (int i = 0; i < 81; i++)
  {
    if (i%9 == 0) Collections.shuffle(arr);
    int perBox = ((i / 3) % 3) * 9 + ((i % 27) / 9) * 3 + (i / 27) * 27 + (i %3);
    grid[perBox] = arr.get(i%9);
  }

  //tracks rows and columns that have been sorted
  boolean[] sorted = new boolean[81];

  for (int i = 0; i < 9; i++)
  {
    boolean backtrack = false;
    //0 is row, 1 is column
    for (int a = 0; a<2; a++)
    {
      //every number 1-9 that is encountered is registered
      boolean[] registered = new boolean[10]; //index 0 will intentionally be left empty since there are only number 1-9.
      int rowOrigin = i * 9;
      int colOrigin = i;

    ROW_COL: 
      for (int j = 0; j < 9; j++)
      {
        //row/column stepping - making sure numbers are only registered once and marking which cells have been sorted
        int step = (a%2==0? rowOrigin + j: colOrigin + j*9);
        int num = grid[step];

        if (!registered[num]) registered[num] = true;
        else //if duplicate in row/column
        {
          //box and adjacent-cell swap (BAS method)
          //checks for either unregistered and unsorted candidates in same box,
          //or unregistered and sorted candidates in the adjacent cells
          for (int y = j; y >= 0; y--) 
          {
            int scan = (a%2==0? i * 9 + y: i + 9 * y);
            if (grid[scan] == num)
            {
              //box stepping
              for (int z = (a%2==0? (i%3 + 1) * 3: 0); z < 9; z++)
              {
                if (a%2 == 1 && z%3 <= i%3)
                  continue;
                int boxOrigin = ((scan % 9) / 3) * 3 + (scan / 27) * 27;
                int boxStep = boxOrigin + (z / 3) * 9 + (z % 3);
                int boxNum = grid[boxStep];
                if ((!sorted[scan] && !sorted[boxStep] && !registered[boxNum])
                  || (sorted[scan] && !registered[boxNum] && (a%2==0? boxStep%9==scan%9: boxStep/9==scan/9)))
                {
                  grid[scan] = boxNum;
                  grid[boxStep] = num;
                  registered[boxNum] = true;
                  continue ROW_COL;
                } else if (z == 8) //if z == 8, then break statement not reached: no candidates available
                {
                  //Preferred adjacent swap (PAS)
                  //Swaps x for y (preference on unregistered numbers), finds occurence of y
                  //and swaps with z, etc. until an unregistered number has been found
                  int searchingNo = num;

                  //noting the location for the blindSwaps to prevent infinite loops.
                  boolean[] blindSwapIndex = new boolean[81];

                  //loop of size 18 to prevent infinite loops as well. Max of 18 swaps are possible.
                  //at the end of this loop, if continue or break statements are not reached, then
                  //fail-safe is executed called Advance and Backtrack Sort (ABS) which allows the 
                  //algorithm to continue sorting the next row and column before coming back.
                  //Somehow, this fail-safe ensures success.
                  for (int q = 0; q < 18; q++)
                  {
                  SWAP: 
                    for (int b = 0; b <= j; b++)
                    {
                      int pacing = (a%2==0? rowOrigin+b: colOrigin+b*9);
                      if (grid[pacing] == searchingNo)
                      {
                        int adjacentCell = -1;
                        int adjacentNo = -1;
                        int decrement = (a%2==0? 9: 1);

                        for (int c = 1; c < 3 - (i % 3); c++)
                        {
                          adjacentCell = pacing + (a%2==0? (c + 1)*9: c + 1);

                          //this creates the preference for swapping with unregistered numbers
                          if (   (a%2==0 && adjacentCell >= 81)
                            || (a%2==1 && adjacentCell % 9 == 0)) adjacentCell -= decrement;
                          else
                          {
                            adjacentNo = grid[adjacentCell];
                            if (i%3!=0
                              || c!=1 
                              || blindSwapIndex[adjacentCell]
                              || registered[adjacentNo])
                              adjacentCell -= decrement;
                          }
                          adjacentNo = grid[adjacentCell];

                          //as long as it hasn't been swapped before, swap it
                          if (!blindSwapIndex[adjacentCell])
                          {
                            blindSwapIndex[adjacentCell] = true;
                            grid[pacing] = adjacentNo;
                            grid[adjacentCell] = searchingNo;
                            searchingNo = adjacentNo;

                            if (!registered[adjacentNo])
                            {
                              registered[adjacentNo] = true;
                              continue ROW_COL;
                            }
                            break SWAP;
                          }
                        }
                      }
                    }
                  }
                  //begin Advance and Backtrack Sort (ABS)
                  backtrack = true;
                  break ROW_COL;
                }
              }
            }
          }
        }
      }

      if (a%2==0)
        for (int j = 0; j < 9; j++) sorted[i*9+j] = true; //setting row as sorted
      else if (!backtrack) 
        for (int j = 0; j < 9; j++) sorted[i+j*9] = true; //setting column as sorted
      else //reseting sorted cells through to the last iteration
      {
        backtrack = false;
        for (int j = 0; j < 9; j++) sorted[i*9+j] = false;
        for (int j = 0; j < 9; j++) sorted[(i-1)*9+j] = false;
        for (int j = 0; j < 9; j++) sorted[i-1+j*9] = false;
        i-=2;
      }
    }
  }

  if (!isPerfect(grid)) throw new RuntimeException("ERROR: Imperfect grid generated.");

  return grid;
}


boolean isPerfect(int[] grid)
{
  if (grid.length != 81) throw new IllegalArgumentException("The grid must be a single-dimension grid of length 81");

  //tests to see if the grid is perfect

  //for every box
  for (int i = 0; i < 9; i++)
  {
    boolean[] registered = new boolean[10];
    registered[0] = true;
    int boxOrigin = (i * 3) % 9 + ((i * 3) / 9) * 27;
    for (int j = 0; j < 9; j++)
    {
      int boxStep = boxOrigin + (j / 3) * 9 + (j % 3);
      int boxNum = grid[boxStep];
      registered[boxNum] = true;
    }
    for (boolean b : registered) 
      if (!b) return false;
  }

  //for every row
  for (int i = 0; i < 9; i++)
  {
    boolean[] registered = new boolean[10];
    registered[0] = true;
    int rowOrigin = i * 9;
    for (int j = 0; j < 9; j++)
    {
      int rowStep = rowOrigin + j;
      int rowNum = grid[rowStep];
      registered[rowNum] = true;
    }
    for (boolean b : registered) 
      if (!b) return false;
  }

  //for every column
  for (int i = 0; i < 9; i++)
  {
    boolean[] registered = new boolean[10];
    registered[0] = true;
    int colOrigin = i;
    for (int j = 0; j < 9; j++)
    {
      int colStep = colOrigin + j*9;
      int colNum = grid[colStep];
      registered[colNum] = true;
    }
    for (boolean b : registered) 
      if (!b) return false;
  }

  return true;
}
