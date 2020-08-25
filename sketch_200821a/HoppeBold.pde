class HoppeBold {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float diameter;
  float radius;

  float xBoundary;
  float yBoundary;
  
  HoppeBold(int diameter, int mass, int grassHeight) {
    this.diameter = diameter;
    this.radius = diameter / 2;
    this.xBoundary = width - radius;
    this.yBoundary = height - radius - grassHeight;

    // Lav en lokations vektor med tilfældige x og y koordinater
    // De tilfældige tal genereres i intervallet [radiues; vinduets længder MINUS radiues].
    // Det sørger for at bolden ikke "spawner" ude fra vinduet!
    this.location = new PVector(
      random(radius, xBoundary), 
      random(radius, yBoundary)
    );

    int velocityScalar = 2;
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
    if (velocity.mag() > 20) {
      velocity.normalize();
      velocity.mult(19);
    }
    velocity.add(acceleration);
    location.add(velocity);
  }

  void display() {
    fill(127,255,0);
    circle(location.x, location.y, diameter);
  }

  void checkCollision(Bakke[] bakker, ArrayList<HoppeBold> hoppeBolde) {
    for (Bakke bakke : bakker) {
      // Boldens radius og bakkens radiues lægges sammen
      // så vi får den minimum længde de kan være fra hinanden
      float minimumDist = radius + bakke.diameter / 2;
      float actualDist = dist(location.x, location.y, bakke.x, bakke.y);
      if (actualDist < minimumDist) {
        // En del af koden under denne kommentar er stjålet herfra: https://processing.org/examples/bouncybubbles.html
        float dx = bakke.x - location.x;
        float dy = bakke.y - location.y;
        float spring = 0.5;
        
        float angle = atan2(dy, dx);
        float targetX = location.x + cos(angle) * minimumDist;
        float targetY = location.y + sin(angle) * minimumDist;
        float ax = (targetX - bakke.x) * spring;
        float ay = (targetY - bakke.y) * spring;
        velocity.sub(new PVector(ax, ay));
        createFrictionForce();
      } 
    }
    
    for (HoppeBold hoppeBold : hoppeBolde) {
      float minDist = hoppeBold.radius + radius;
      float actualDist = dist(location.x, location.y, hoppeBold.location.x, hoppeBold.location.y);
      
      if (actualDist < minDist) {
        float dx = hoppeBold.location.x - location.x;
        float dy = hoppeBold.location.y - location.y;
        float spring = 0.5;
        
        float angle = atan2(dy, dx);
        float targetX = location.x + cos(angle) * minDist;
        float targetY = location.y + sin(angle) * minDist;
        float ax = (targetX - hoppeBold.location.x) * spring;
        float ay = (targetY - hoppeBold.location.y) * spring;
        
        PVector velocity2 = new PVector(ax, ay);
        velocity.sub(velocity2);
        
        hoppeBold.velocity.add(velocity2);
      }
    }
    
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
