class Player {
  int x;
  int y;
  int column;
  int row;
  int radius;

  Player() {
    noStroke();
    radius = Cell.side - 2*Cell.strokeWidth;
    x = 10 + 10;
    y = 10 + 20;
    
    // column and row track the location of the player 
    // and correspond to the column and row that call the cells from the array
    // which allows the player to check that a cell it is trying to move into
    // is open
    column = 0;
    row = 0;
  }

  void display() {
    // color switches by level
    color fillColor = level % 2 != 0 ? main1 : main2;
    fill(fillColor);
    ellipse (10 + column * Cell.side, 30 + row * Cell.side, radius, radius);
  }

  void up() {
      y-=Cell.side;
      row--;
      visit();
  }
  void down() {
      y+=Cell.side;
      row++;
      visit();
  }
  void left() { 
      x-=Cell.side;
      column--;
      visit();
  }
  void right() {
      x+=Cell.side;
      column++;
      visit();
  }
  
  void visit() {
    board[column][row].visited = true;
  }
  
  void setupLevel(int lvl) {
    x = 10+(Cell.side*(lvl-1));
    y = 30+(Cell.side*(lvl-1));
    column = lvl-1;
    row = lvl-1;
    visit();
  }
}

