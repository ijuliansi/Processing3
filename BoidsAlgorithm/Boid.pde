class Boid {
  PVector position, velocity, acceleration;
  float size;
  
  //self explanatory
  float maxSpeed = 4;
  float maxForce = 0.2;

  //set the distance each boid can see to do cohesion/align/separation
  float sViewDist = 25;
  float aViewDist = 40;
  float cViewDist = 30;
  float predViewDist = 50;
  float viewAngle = radians(70); // sets up each boid's field of view

  // sets a custom multiplication factor for each behavior
  float sFactor = 0.04;
  float aFactor = 0.05;
  float cFactor = 0.04;

  boolean isNearPred = false;

  //constructor
  Boid(PVector position, PVector velocity, float size) {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = new PVector(0, 0);
    this.size = map(size, 1, 10, 2, 5);
  }

  // tells each boid to get away from other boids
  PVector separation(Boid[] otherBoid) {
    PVector steer = new PVector(0, 0);

    for (Boid b : otherBoid) {
      PVector dist = new PVector(this.position.x - b.position.x, this.position.y - b.position.y);
      //float dist = dist(this.position.x, this.position.y, b.position.x, b.position.y);
      if (b != this && dist.mag() < sViewDist && this.angleBetween(this.velocity, dist) < viewAngle * 2) {
        steer.x += this.position.x - b.position.x;
        steer.y += this.position.y - b.position.y;
      }
    }

    steer.mult(sFactor);

    return steer;
  }

  // tells each boid to align their direction with the surrounding boid's direction
  PVector align(Boid[] otherBoid) {
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (Boid b : otherBoid) {
      PVector dist = new PVector(this.position.x - b.position.x, this.position.y - b.position.y);
      //float dist = dist(this.position.x, this.position.y, b.position.x, b.position.y); 
      if (b != this && dist.mag() < aViewDist && this.angleBetween(this.velocity, dist) < viewAngle * 2) {
        steer.add(b.velocity);
        count++;
      }
    }

    if (count > 0) {
      steer.div(count);
      steer.sub(this.velocity);
      steer.mult(aFactor);
    } else {
      steer.set(0, 0);
    }
    return steer;
  }

  // tells each boid to go to the center of mass of the surrounding boids
  PVector cohesion(Boid[] otherBoid) {
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (Boid b : otherBoid) {
      PVector dist = new PVector(this.position.x - b.position.x, this.position.y - b.position.y);
      //float dist = dist(this.position.x, this.position.y, b.position.x, b.position.y);
      if (b != this && dist.mag() < cViewDist && this.angleBetween(this.velocity, dist) < viewAngle * 2) {
        steer.add(b.position);
        count++;
      }
    }

    if (count > 0) {
      steer.div(count);
      steer.sub(this.position);
      steer.mult(cFactor);
    } else {
      steer.set(0, 0);
    }

    return steer;
  }

  void predator(PVector pred) {
    float dist = dist(this.position.x, this.position.y, pred.x, pred.y);

    if (this.isNearPred == false) {
      this.isNearPred = true;
      if (dist < predViewDist) {
        //steer.x += this.position.x - pred.x;
        //steer.y += this.position.y - pred.y;

        float difX = abs(this.position.x - pred.x);
        float difY = abs(this.position.y - pred.y);
        if (difX > difY) {
          this.velocity.x *= -1.3;
        } else if (difX == difY) {
          this.velocity.mult(-1);
        } else {
          this.velocity.y *= -1.3;
        }
      }
    }
    if (dist > predViewDist) this.isNearPred = false;
  }
  
  // applies all of the above functions
  void boidThing(Boid[] b) {
    PVector separation = this.separation(b);
    PVector alignment = this.align(b);
    PVector cohesion = this.cohesion(b);

    this.acceleration.add(separation);
    this.acceleration.add(alignment);
    this.acceleration.add(cohesion);
  }

  // moves the boid that goes out of frame
  void boidGoBack() {
    if (this.position.x < - 50) this.position.x = width + 50; // moves the boid if they go out of the window
    if (this.position.x > width + 50) this.position.x = - 50;
    if (this.position.y < - 50) this.position.y = height + 50;
    if (this.position.y > height + 50) this.position.y = - 50;
  }
  
  // updates each boid's velocity and position
  void update() {
    this.acceleration.mult(0.4); //makes the change in velocity&pos less absurd
    this.velocity.add(this.acceleration);
    this.velocity.limit(maxSpeed);
    this.position.add(this.velocity);
    this.acceleration.mult(0.0001);
  }

  // displays the boid as a point with a certain size/thickness that depends on their size
  void show() {
    stroke(255);
    strokeWeight(this.size);
    point(this.position.x, this.position.y);
  }

  // self explanatory, i guess
  float angleBetween(PVector a, PVector b) {
    float angle = acos(a.dot(b) / (a.mag() * b.mag()));
    return angle;
  }
}
