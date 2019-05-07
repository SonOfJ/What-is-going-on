interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    fill(255);
    ellipse(x,y,3,3);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    float rand = (int)random(4);
    if (rand == 0) {
      for (int i = 0; i < 5; i = i + 1) {
        x = x + 1;
      }
    }
    if (rand == 1) {
      for (int i = 0; i < 5; i = i + 1) {
        y = y + 1;
      }
    }
    if (rand == 2) {
      for (int i = 0; i < 5; i = i + 1) {
        x = x - 1;
      }
    }
    if (rand == 3) {
      for (int i = 0; i < 5; i = i + 1) {
        y = y - 1;
      }
    }
  }
}

class Ball extends Thing implements Moveable {
  float ballsize = (int)random(50);
  float R = (int)random(225);
  float G = (int)random(225);
  float B = (int)random(225);
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(R, G, B);
    circle(this.x, this.y, ballsize / 2);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    float x = this.x;
    float y = this.y;
    float num = (int)random(4);
    if (num == 0){
      x += random(-10,10);
    }
    else if (num == 1){
      y += random(-10,10);
    }
    else if (num == 2){
      x -= random(-10,10);
    }
    else{
      y -= random(-10,10);
    }
    if (x <= 0 + this.ballsize){
      x += random(10);
    }
    else if (x >= 1000 - this.ballsize){
      x -= random(10);
    }
    if (y <= 0 + this.ballsize){
      y += random(10);
    }
    else if (y >= 800 - this.ballsize){
      y -= random(10);
    }
    this.x = x;
    this.y = y;
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}