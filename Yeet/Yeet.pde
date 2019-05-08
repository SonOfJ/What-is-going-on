interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
interface Collideable {
  boolean isTouching(Thing other);
}
abstract class Thing implements Displayable {
  float x, y;//Position of the Thing
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}
class Rock extends Thing implements Collideable {
  PImage img;
  Rock(float x, float y) {
    super(x, y);
    if ((int)random(2) == 0) { //Randomly select one of the images of a rock.
      img = loadImage("FirstRock.jpg");
    } else {
      img = loadImage("SecondRock.jpg");
    }
  }
  void display() {
    image(img, x, y, 100, 100);
  }
  boolean isTouching(Thing other) {
    return x == other.x && y == other.y;
  }
}
public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    float rand = (int)random(4);
    if (rand == 0) { //Move to the right.
      for (int i = 0; i < 5; i = i + 1) {
        x = x + 1;
      }
    }
    if (rand == 1) { //Move down.
      for (int i = 0; i < 5; i = i + 1) {
        y = y + 1;
      }
    }
    if (rand == 2) { //Move to the left.
      for (int i = 0; i < 5; i = i + 1) {
        x = x - 1;
      }
    }
    if (rand == 3) { //Move up.
      for (int i = 0; i < 5; i = i + 1) {
        y = y - 1;
      }
    }
  }
  void display() {
    super.display();
    fill(255); //White.
    ellipse(x + 25, y + 40, 40, 25); //Right eye.
    ellipse(x + 75, y + 40, 40, 25); //Left eye.
    fill(0); //Black.
    ellipse(x + 25, y + 40, 20, 20); //Right iris
    ellipse(x + 75, y + 40, 20, 20); //Left iris.
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
    fill(R, G, B);
    circle(this.x, this.y, ballsize / 2);
  }
  void move() {
    float x = this.x;
    float y = this.y;
    float num = (int)random(4);
    if (num == 0) {
      x += random(-10, 10);
    } else if (num == 1) {
      y += random(-10, 10);
    } else if (num == 2) {
      x -= random(-10, 10);
    } else {
      y -= random(-10, 10);
    }
    if (x <= 0 + this.ballsize) {
      x += random(10);
    } else if (x >= 1000 - this.ballsize) {
      x -= random(10);
    }
    if (y <= 0 + this.ballsize) {
      y += random(10);
    } else if (y >= 800 - this.ballsize) {
      y -= random(10);
    }
    this.x = x;
    this.y = y;
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
  }
  for (int i = 0; i < 1; i = i + 1) {
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 1; i++) {
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
