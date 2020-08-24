class HoppeBold {
  PVector location;
  PVector velocity;
  PVector acceleration;

  int diameter;
  int mass;

  HoppeBold(int diameter, int mass) {
    this.diameter = diameter;
    this.mass = mass;
    float radius = diameter / 2;

    // Lav en lokations vektor med tilfældige x og y koordinater
    this.location = new PVector(
      random(radius, width - radius),
      random(radius, height - radius)
    );

    // Lav en velocity vektor med en tilfældig retning men med samme faste skalar.
    // Så den altid vil have nogenlunde fast fart
    int velocityScalar = 8;
    this.velocity = new PVector(
      random(1) * velocityScalar,
      random(1) * velocityScalar
    );

    // Tyngdekrafts vektor der peger ned ad mod jorden med en kraft på 9.82 N (y koordinatet er 9.82). 
    PVector earthGravity = new PVector(0, 9.82);
    // Divider earthGravity vektoren med massen.  
    this.acceleration = earthGravity.div(this.mass);
  }
  
  void createFrictionForce() {
    if (this.velocity.x < 0.01 && this.velocity.x > -0.01) this.velocity.x = 0;
    else this.velocity.x += this.velocity.x < 0 ? 0.01 : -0.01;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void display() {
    circle(location.x, location.y, diameter);
  }

  void checkEdges() {
    if (location.x > width) {
      velocity.x *= -1;
      location.x = width;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
      // Lav friktion så snart at bolden rører jorden
      createFrictionForce();
    } else if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    }
  }
}
