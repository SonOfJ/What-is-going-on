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
    x = x + random(-1, 1);
    y = y + random(-1, 1);
  }
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
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
    if (x == 25){
      x += random(10);
    }
    else if (x == 175){
      x -= random(10);
    }
    if (y <= 25){
      y += random(10);
    }
    else if (y >= 775){
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
