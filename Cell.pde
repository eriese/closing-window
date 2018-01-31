class Cell {  
  static int side = 20;
  static int strokeWidth = 2;
  
  //ints to draw cell
  int col;
  int row;

  //cell state
  boolean visited;
  
  color fillColor;

  Cell(int colNum, int rowNum) {
    //initial state of Cell is visited = false
    col = colNum;
    row = rowNum;
    visited = false;
    rectMode(CORNER);
    strokeWeight(strokeWidth);
  }

  void display() {
    getColor();
    stroke(strokeColor);
    fill(fillColor);
    rect(col*side, side + row*side, side, side);
  }
  
  void getColor() {
    if((level % 2 == 0 && visited) || (level % 2 == 1 && !visited)) {
//      strokeColor = main2;
      fillColor = main1;
    }
    else {
//      strokeColor = main1;
      fillColor = main2;
    }
  }
}

