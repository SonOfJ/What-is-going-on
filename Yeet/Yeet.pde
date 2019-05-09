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
    if (rand == 0 && x + 100 < 1000) { //Move to the right.
      for (int i = 0; i < 5; i = i + 1) {
        x = x + 1;
      }
    }
    if (rand == 1 && y + 100 < 800) { //Move down.
      for (int i = 0; i < 5; i = i + 1) {
        y = y + 1;
      }
    }
    if (rand == 2 && x > 0) { //Move to the left.
      for (int i = 0; i < 5; i = i + 1) {
        x = x - 1;
      }
    }
    if (rand == 3 && y > 0) { //Move up.
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
  float xmove = random(-1, 1);
  float ymove = random(-1,1);
  Ball(float x, float y) {
    super(x, y);
  }
  void display() {
    fill(R, G, B);
    circle(this.x, this.y, ballsize / 2);
  }
  void move() {
    if (this.x + ballsize / 2 >= width || this.x - ballsize / 2 <= 0){
      xmove *= -1;
    }
    if (this.y + ballsize / 2 >= width || this.y - ballsize / 2 <= 0){
      ymove *= -1;
    }
    this.x += xmove;
    this.y += ymove;
    
  }
  boolean isTouching(Rock r){
    return this.x == r.x && this.y == r.y;
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
  for (int i = 0; i < 3; i = i + 1) {
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    r.img = loadImage("Dead" + (i + 1) + ".jpg");
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    m.img = loadImage("Live" + (i + 1) + ".jpg");
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
