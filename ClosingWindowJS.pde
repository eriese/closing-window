int scene; // switch variable
int count; // counts how many games have been played, for tracking high score
int level; // counts level
int goalCount; // counts up goals
int movecount; // counts moves
int timer; // counts frames
int time; // counts seconds
int highTime; // best time
int highMove; // lowest move count
int highLevel; // level of lowest move count

// Controls
int w = 482; // width
int h = 480; // height
float s = 1.5; // scale
int frame = 90; // framecount
int goalMax = 10; // number of goals per level
int columns = 24; 
int rows = 22;
color alter = color (0, 150, 30); // object and text color
color main1 = color (45,15,48);
color main2 = color (174,83,194);
color strokeColor = color(237,174,255);
color backgroundColor = main1;

//Objects
//import ddf.minim.*;
//Minim minim;
//AudioSample sound1;
//AudioSample sound2;
//AudioSample sound3;
//AudioSample sound4;
//AudioSample sound5;
//AudioSample sound6;
Goal[] goal;
Goal g;
Cell[][] board;
Cell cell;
Player player;

void setup() {
  size(482, 480);
  noStroke();
//  minim = new Minim(this);
//  //load sound
//  sound1 = minim.loadSample("goal.mp3"); // goal sound
//  sound2 = minim.loadSample("level.mp3"); // level up sound
//  sound3 = minim.loadSample("move1.mp3"); // vertical move sound
//  sound4 = minim.loadSample("blocked.mp3"); // blocked sound
//  sound5 = minim.loadSample("lose.mp3"); // lose sound
//  sound6 = minim.loadSample("move2.mp3"); // horizontal move sounds
  smooth();
  PFont font;
  font = loadFont("Courier-18.vlw");
  textFont(font, 18);
  frameRate(frame);
  // Initialize objects:
  // instantiate all goals using an array
  goal = new Goal[goalMax];
  for (int k = 0; k < goalMax; k++) {
    goal[k] = new Goal();
  }
  // instantiate all cells using two arrays by column and row
  board = new Cell[columns][rows];
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      board[i][j] = new Cell(i,j);
    }
  }
  //instantiate player
  player = new Player();
}

void draw() {
  background(backgroundColor);
  switch(scene) {
  case 0 :
    String str = "Use the arrow keys to play. Be careful! There's no going back.";
    fill(alter);
    textAlign(CENTER, CENTER);
    text(str, 10, 10, 470, 470);
    level = 0;
    break;
  case 1 :
    // Level refresh. this is the beginning of the game loop.
    textAlign(LEFT);
    // background alternates based on level
    backgroundColor = level % 2 == 0 ? main2 : main1;
    background(backgroundColor);
    // Record high score
    if (level == 1) {
      highMove = movecount;
      highLevel = 1;
    }
    else if (level > 1) {
      if (movecount < highMove) {
        highMove = movecount;
        highLevel = level;
      }
    }
    // Initialize level
    level++;
    goalCount = 0;
    movecount = 0;
    // Reset Goals
    for (int k = 0; k < goalMax; k++) {
      goal[k].reset();
    }

    // Reset Board
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j].visited = false;
      }
    }
    // Close the window by setting the border cells to visited
    for (int i = 0; i < columns; i++) { 
      for (int j = 0; j<level-1; j++) {  
        board[i][j].visited = true;
        board[i][rows-(j+1)].visited = true;
      }
    }
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j<level-1; j++) {
        board[j][i].visited = true;
        board[columns-(j+1)][i].visited = true;
      }
    }
    player.setupLevel(level);
    scene++;
    break;
  case 2 :
    // Game Screen
    // Environment
//    if (level%2 != 0) {
//      background(main2);
//    }
//    else {
//      background (main1);
//    }
    background(strokeColor);
    fill(alter);
    text("MOVES:  " + movecount, 10, 475);
    //    text("time: " + time, 10, 375);
    text("GOALS: " + goalCount + "/" + goalMax, 345, 475);
    text("PRESS SHIFT TO GIVE UP", 120, 16);
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }  
    goal[goalCount].display();
    goal[goalCount].achievement();
    player.display();
    timer++;
    time = timer/frame;
    if (goal[goalCount].achieved == true) {
//      sound1.trigger();
      goalCount++;
//      println("goal:" + goalCount);
      if (goal[goalMax-1].achieved == true) {
//        sound2.trigger();
        scene = 1;
      }
    }
    break;
  case 3 :
    // End Screen
    background(0);
    fill(alter);
    text("Oops.", 30, 180); 
    text("It seems you didn't plan well enough.", 30, 200);
    //    text("Best time: " + highTime, 10, 215);
    text("Last score: " + movecount + ", Level " + level, 30, 220);
    if (highMove == 0) {
      text("Best score: N/A", 30, 240);
    }
    else {
      text("Best score: " + highMove + ", Level " + highLevel, 30, 240);
    }
    break;
  }
}

void keyPressed() {

  if (key == CODED) {
    if (scene == 2) {
      if (keyCode == UP && player.y>30) {
        if (board[player.column][player.row-1].visited != true) {
          //          sound3.trigger();
          player.up();
          movecount++;
        }
        else {
          //          sound4.trigger();
        }
      }
      else if (keyCode == DOWN && player.y<450) {
        if (board[player.column][player.row+1].visited != true) {
          //          sound3.trigger();      
          player.down();
          movecount++;
        }
        else {
          //          sound4.trigger();
        }
      }
      else if (keyCode == LEFT && player.x>10) {
        if (board[player.column-1][player.row].visited != true) {
//          sound6.trigger();
          player.left();
          movecount++;
        }
        else {
//          sound4.trigger();
        }
      }
      else if (keyCode == RIGHT && player.x<470) {
        if (board[player.column+1][player.row].visited != true) {
//          sound6.trigger();
          player.right();
          movecount++;
        }
        else {
//          sound4.trigger();
        }
      }
      else if (keyCode == SHIFT) {
        scene = 3;
//        sound5.trigger();
      }
    }
    else if (scene == 0) {
      background(255, 10, 100);
      scene = 1;
    }
    else if (scene == 3) {
      scene = 0;
    }
    else {
      scene = 0;
    }
  }
}

