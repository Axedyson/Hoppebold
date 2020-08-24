class HoppeBold {
  PVector location;
  PVector velocity;
  PVector acceleration;

  int diameter;
  int radius;

  float xBoundary;
  float yBoundary;


  HoppeBold(int diameter, int mass) {
    this.diameter = diameter;
    this.radius = diameter / 2;
    this.xBoundary = width - radius;
    this.yBoundary = height - radius;

    // Lav en lokations vektor med tilfældige x og y koordinater
    // De tilfældige tal genereres i intervallet [radiues; vinduets længder MINUS radiues].
    // Det sørger for at bolden ikke "spawner" ude fra vinduet!
    this.location = new PVector(
      random(radius, xBoundary), 
      random(radius, yBoundary)
    );

    int velocityScalar = 8;
    this.velocity = new PVector(
      random(1) * velocityScalar, 
      random(1) * velocityScalar
    );

    // Tyngdekrafts vektor der peger ned ad mod jorden med en kraft på 9.82 N (y koordinatet er 9.82). 
    PVector earthGravity = new PVector(0, 9.82);
    // Divider earthGravity vektoren med massen.
    this.acceleration = earthGravity.div(mass);
  }

  void createFrictionForce() {
    // Hvis boldens fart hen ad x-aksen er mindre ind 0.01 eller over -0.01 så sættes x til 0.
    // Bolden vil opføre sig underligt og blive ved med at bevæge sig hvis vi ikke gjorde det.
    if (velocity.x < 0.01 && velocity.x > -0.01) velocity.x = 0;
    // Hvis veloctiy.x er negativ så lægger vi 0.01 til og -0.01 hvis positiv.
    // På den måde vil vi hele tiden modvirke farten i x retningen og dermed simulere en slags friktion!
    else velocity.x += velocity.x < 0 ? 0.01 : -0.01;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void display() {
    circle(location.x, location.y, diameter);
  }

  void checkEdges() {
    if (location.x >= xBoundary) {
      velocity.x *= -1;
      location.x = xBoundary;
    } else if (location.x <= radius) {
      velocity.x *= -1;
      location.x = radius;
    }

    if (location.y >= yBoundary) {
      velocity.y *= -1;
      location.y = yBoundary;
      // Lav friktion så snart at bolden rører jorden
      createFrictionForce();
    } else if (location.y <= radius) {
      velocity.y *= -1;
      location.y = radius;
    }
  }
}
