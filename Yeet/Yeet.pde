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
  float xdir;
  float ydir;
  float mode;
  LivingRock(float x, float y) {
    super(x, y);
    if ((int)random(2) == 0) {
      xdir = -1;
    } else {
      xdir = 1;
    }
    if ((int)random(2) == 0) {
      ydir = -1;
    } else {
      ydir = 1;
    }
    if ((int)random(3) == 0) {
      mode = 1;
    } else if ((int)random(2) == 0) {
      mode = 2;
    } else {
      mode = 3;
    }
  }
  void move() {
    if (x >= 900 || x <= 0) {
      xdir = xdir * -1; 
    }
    if (y >= 700 || y <= 0) {
      ydir = ydir * -1;
    }
    if (mode == 1) {
      x = x + abs(10 - 9 * abs(x - 500) / 500) * xdir;
      y = y + abs(10 - 9 * abs(y - 400) / 400) * ydir;
    }
    if (mode == 2) {
      x = x + abs(1 + 9 * abs(x - 500) / 500) * xdir;
      y = y + abs(1 + 9 * abs(y - 400) / 400) * ydir;
    }
    if (mode == 3) {
      x = x + 5.5 * xdir;
      y = y + 5.5 * ydir;
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
  boolean isTouching(Thing rock){
    return this.x == rock.x && this.y == rock.y;
  }
}
class Superball extends Ball{
  float ballsize = (int)random(40) + 11;
  float xmove = random(-1, 1);
  float ymove = random(-1,1);
  Superball(float x, float y){
    super(x, y);
  }
    void display() {
    fill(250,128,114);
    circle(this.x, this.y, ballsize / 2);
  }
  void move() {
    if (this.x + ballsize / 2 >= width || this.x - ballsize / 2 <= 0){
      xmove *= -1 * ((int)random(15) + 1);
    }
    if (this.y + ballsize / 2 >= width || this.y - ballsize / 2 <= 0){
      ymove *= -1 + ((int)random(15) + 1);
    }
    this.x += xmove;
    this.y += ymove;
  }
}

class Badball extends Ball{
  float ballsize = (int)random(40) + 11;
  float xmove = random(-1, 1);
  float ymove = random(-1,1);
  Badball(float x, float y){
    super(x, y);
  }
    void display() {
    fill(153,204,255);
    circle(this.x, this.y, ballsize / 2);
  }
  void move() {
    if (this.x + ballsize / 2 >= width || this.x - ballsize / 2 <= 0){
      xmove /= -1 * ((int)random(15) + 1);
    }
    if (this.y + ballsize / 2 >= width || this.y - ballsize / 2 <= 0){
      ymove /= -1 + ((int)random(15) + 1);
    }
    this.x += xmove;
    this.y += ymove;
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
  for (int i = 0; i < 5; i++) {
    Ball b = new Badball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
  }
  for (int i = 0; i < 5; i++) {
    Ball b = new Superball(50+random(width-100), 50+random(height-100));
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
