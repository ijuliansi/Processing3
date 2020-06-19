/* Newton's Law of Gravitation Visualization
   Julian Syaputra
   Inspired by one of Sebastian Lague's video
*/

int n = 2; // the number of planets
Planet[] p = new Planet[n];
float dt;

ArrayList<Attractor> attract = new ArrayList<Attractor>();

PGraphics trail;

void setup() {
  size(700, 700);
  for (int i = 0; i < p.length; i++) {
    // creates a new planet on a random position 
    p[i] = new Planet(new PVector(random(-width/4, width/4), random(-height/4, height/4)), new PVector(random(0, 0.5), random(0, 0.5)), random(10, 1000)); //random(-5, 5)
  }
  attract.add(new Attractor(new PVector(0, 0), 200));

  trail = createGraphics(width, height);
  trail.beginDraw();
  trail.background(0);
  trail.endDraw();
}

void draw() {
  image(trail, 0, 0);
  translate(width/2, height/2);
  // the outermost for loop makes the iteration significantly faster
  // though it makes the graphics a little bit weird
  for (int iter = 0; iter < 20; iter++) {
    for (int i = 0; i < p.length; i++) {
      p[i].acc.set(0, 0);
      p[i].show();
      //p[i].updateVel(p); commented this because i don't want to see the effect of one planet onto the other
      for (int j = 0; j < attract.size(); j++) {
        Attractor a = attract.get(j);
        p[i].updateVelA(a);
      }
      p[i].updatePos();

      trail.beginDraw();
      trail.colorMode(HSB);
      trail.translate(width/2, height/2);
      trail.stroke(p[i].clr, 255, 255);
      trail.point(p[i].pos.x, p[i].pos.y);
      trail.endDraw();
    }
  }

  for (int i = 0; i < attract.size(); i++) {
    Attractor a = attract.get(i);
    a.show();
  }
}

// adds a new attractor when the left mouse button is clicked
void mousePressed() {
  if (mouseButton == LEFT) {
    attract.add(new Attractor(new PVector(mouseX - width/2, mouseY - height/2), random(100, 1000)));
  }
}
