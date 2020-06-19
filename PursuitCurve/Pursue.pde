class Pursue {
  PVector pos, vel;
  float velMag;
  boolean isFox;

  // Fox = the one that moves according to a target (in this case, a rabbit)
  // Rabbit = the one that moves to a certain location with a constant speed
  Pursue(PVector pos, float velMag, boolean isFox) {
    this.pos = pos;
    this.velMag = velMag;
    
    // creates a random velocity vector with magnitude 2 in case of isFox = false
    this.vel = PVector.random2D().setMag(velMag);
    this.isFox = isFox;
  }

  void display() {
    if (isFox) {
      fill(255, 150, 0);
      noStroke();
      //ellipse(this.pos.x, this.pos.y, 20, 20);
      point(this.pos.x, this.pos.y);
    } else {
      fill(255);
      noStroke();
      ellipse(this.pos.x, this.pos.y, 20, 20);
    }
  }

  void update(Pursue rabbit) {
    if (isFox) {
      // based on the general differential equation
      this.vel.set(rabbit.pos.x - this.pos.x, rabbit.pos.y - this.pos.y);
      this.vel.div(this.vel.mag());
      this.vel.mult(this.velMag);
      this.pos.add(this.vel);
    } else this.pos.add(this.vel);
    
    if (this.pos.x < -20) this.pos.x = width + 20;
    if (this.pos.x > width + 20) this.pos.x = -20;
    if (this.pos.y < -20) this.pos.y = height + 20;
    if (this.pos.y > height + 20) this.pos.y = -20;
  }
  
}
