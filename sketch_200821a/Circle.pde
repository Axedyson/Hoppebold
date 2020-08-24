class HoppeBold {
  PVector location;
  PVector velocity;
  PVector gravityForce;

  int diameter;
  int velocityScalar;

  HoppeBold(int diameter, int mass) {
    this.diameter = diameter;
    float radius = diameter / 2;

    // Lav en lokations vektor med tilfældige x og y koordinater
    this.location = new PVector(
      random(radius, width - radius),
      random(radius, height - radius)
    );

    // Lav en velocity vektor med en tilfældig retning men med samme faste skalar.
    // Så den altid vil have nogenlunde fast fart
    this.velocityScalar = 10;
    this.velocity = new PVector(
      random(1) * this.velocityScalar,
      random(1) * this.velocityScalar
    );

    // Lav en tyngdekraft ud fra boldens masse og en tyngdekrafts vektor
    // der peger ned mod jorden
    PVector gravity = new PVector(0, 0.1);
    this.gravityForce = PVector.div(gravity, mass);
  }

  void update() {
    velocity.add(gravityForce);
    location.add(velocity);
  }

  void display() {
    circle(location.x, location.y, diameter);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    } else if (location.y < 0) {
      velocity.y *= -1;
      location.y = 0;
    }
  }
}
