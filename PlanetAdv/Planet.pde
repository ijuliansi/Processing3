class Planet {
  PVector pos, vel, acc, force;

  float m, radius, clr, g = 1; // clr stands for color, g is the universal gravitation constant (6.67 * 10^-23?)

  Planet(PVector pos, PVector vel, float m) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.force = new PVector(0, 0);
    this.m = m;
    //maps the radius and color according to the mass
    this.radius = map(this.m, 10, 1000, 10, 50);
    this.clr = map(this.m, 10, 1000, 0, 100) + 155;
  }

  // updates a planet's velocity based on the force each planets apply to one another
  void updateVel(Planet[] p) {
    for (Planet otherPlanet : p) {
      if (otherPlanet != this) { 
        float dist = dist(this.pos.x, this.pos.y, otherPlanet.pos.x, otherPlanet.pos.y);
        float f = g * this.m * otherPlanet.m / pow(dist, 2);
        this.force.set(f * (otherPlanet.pos.x - this.pos.x), f * (otherPlanet.pos.y - this.pos.y));
        this.force.normalize(); // sets the force vector to be a unit vector
        //this.force.setMag(5);
        this.acc.add(this.force.div(this.m));
        this.vel.add(this.acc);
      }
    }
  }

  // the same as the above function but this one creates a stationary particle/planet/whatever
  void updateVelA(Attractor a) {
    float dist = dist(this.pos.x, this.pos.y, a.pos.x, a.pos.y);
    if (dist != 0) {
      float f = g * this.m * a.m / pow(dist, 2); 
      this.force.set(f * (a.pos.x - this.pos.x), f * (a.pos.y - this.pos.y));
      this.force.normalize();
      this.acc.add(this.force.div(this.m));
      this.vel.add(this.acc);
    }
  }

  void updatePos() {
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  void show() {
    colorMode(HSB);
    fill(this.clr, 255, 255);
    noStroke();
    ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
  }
}

class Attractor {
  PVector pos;
  float m, radius, clr;

  Attractor(PVector pos, float m) {
    this.pos = pos;
    this.m = m;
    this.radius = map(this.m, 10, 1000, 10, 50);
    this.clr = map(this.m, 10, 1000, 10, 100) + 155;
  }

  void show() {
    colorMode(HSB);
    fill(255);
    noStroke();
    ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
  }
}
