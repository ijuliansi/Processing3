/* Boids Algorithm
   Julian Syaputra
   Inspired by Sebastian Lague and SmarterEveryDay's video on the same topic
   Used https://eater.net/boids and https://github.com/mdodsworth/pyglet-boids as a reference
*/

int n = 200;
Boid[] flock = new Boid[n];

ArrayList<PVector> predator = new ArrayList<PVector>(0);

void setup() {
  size(900, 700);
  // creates boid objects with a random initial position, velocity, and size
  for (int i = 0; i < flock.length; i++) {
    flock[i] = new Boid(new PVector(random(width), random(height)), PVector.random2D(), random(1, 10));
  }
}

void draw() {
  background(0, 0, 100);
  // displays a predator
  for (PVector p : predator) {
    fill(255, 0, 0);
    noStroke();
    ellipse(p.x, p.y, 20, 20);
  }
  // executes each of the boid's functions/methods to each boid object
  for (Boid b : flock) {
    b.show();
    for (int i = 0; i < predator.size(); i++) {
      b.predator(predator.get(i));
    }
    b.boidThing(flock);
    b.boidGoBack();
    b.update();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    predator.add(new PVector(mouseX, mouseY));
  }
}
