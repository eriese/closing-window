class Goal {

  int goalColA;
  int goalRowA;
  int goalColB;
  int goalRowB;
  int goalColC;
  int goalRowC;
  int goalSize = Cell.side - 2*Cell.strokeWidth;
  boolean achieved;
  boolean achieveda;
  boolean achievedb;
  boolean achievedc;

  Goal() {
    reset();
    achieveda = false;
    achievedb = false;
    achievedc = false;
  }

  void display() {
    smooth();
    noStroke();
    fill(alter);
    ellipse(10+Cell.side*goalColA, 30+Cell.side*goalRowA, goalSize, goalSize);
    ellipse(10+Cell.side*goalColB, 30+Cell.side*goalRowB, goalSize, goalSize);
    ellipse(10+Cell.side*goalColC, 30+Cell.side*goalRowC, goalSize, goalSize);
    if (achieved == false) {
      achieveda = false;
      achievedb = false;
      achievedc = false;
    }
  }

  void achievement() {
    if (achieved == false) {
      if (player.column == goalColA && player.row == goalRowA) { 
        achieved = true;
        achieveda = true;
      }
      else if (player.column == goalColB && player.row == goalRowB) {
        achieved = true;
        achievedb = true;
      }
      else if (player.column == goalColC && player.row == goalRowC) {
        achieved = true;
        achievedc = true;
      }
      if (achieveda == true) {
        goalXb = -100;
        goalYb = -100;
        goalXc = -100;
        goalYc = -100;
      }
      else if (achievedb == true) {
        goalXa = -100;
        goalYa = -100;
        goalXc = -100;
        goalYc = -100;
      }
      else if (achievedc == true) {
        goalXb = -100;
        goalYb = -100;
        goalXa = -100;
        goalYa = -100;
      }
    }
  }

  void reset() {
    int levelMin = level - 1;
    int columnsMax = columns - (level + 1);
    int rowsMax = rows - (level + 1);
    goalColA = (int)random(levelMin, columnsMax);
    goalRowA = (int)random(levelMin, rowsMax);
    goalColB = (int)random(levelMin, columnsMax);
    goalRowB = (int)random(levelMin, rowsMax);
    goalColC = (int)random(levelMin, columnsMax);
    goalRowC = (int)random(levelMin, rowsMax);
    achieved = false;
  }
}

