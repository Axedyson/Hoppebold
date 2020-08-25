HoppeBold hoppeBold;
int randomSeed;

// Programmet fungerer åbenbart ikke hensigtsmæssigt
// når man initialiserer grassHeight variablen inde i setup() metoden  :/
int grassHeight = 7;

Bakke[] bakker = new Bakke[2];
ArrayList<HoppeBold> hoppeBolde = new ArrayList<HoppeBold>();

void setup() {
	size(900, 900);
  randomSeed = int(random(999999999));
  
  // Lav hoppebold
  for (int i = 0; i < 10; i++) hoppeBolde.add(new HoppeBold(50, 20, grassHeight));
  
  // Lav bakker!
  for (int i = 0; i < bakker.length; i++) bakker[i] = new Bakke();
}

void draw() {
	background(25, 170, 229);
  drawNiceBackground();
  for (HoppeBold hoppeBold : hoppeBolde) {
    ArrayList<HoppeBold> hoppeBolde2 = new ArrayList<HoppeBold>(hoppeBolde);
    hoppeBolde2.remove(hoppeBold);
    
    hoppeBold.update();
    hoppeBold.checkCollision(bakker, hoppeBolde2);
    hoppeBold.display();
  }
}

void drawNiceBackground() {
  // Her sørger vi for at hver gang denne funktion bliver kørt bliver den 
  // indbygget random() funktion i processing ved med at generere de SAMME tilfældige resultater!
  // Læs mere her: https://processing.org/reference/randomSeed_.html
  randomSeed(randomSeed);
  
  drawClouds();
  drawGround();
  
  // Nulstil kant værdier
  stroke(0);
  strokeWeight(1);
}

void drawClouds() {
  for (int i = 0; i < random(10, 30); i++) {

    float x = random(width);
    float y = random(0, height / 3);
    float xSize = random(100, 230);
    float ySize = random(70, xSize);
    
    fill(255);
    noStroke();
    ellipse(x, y, xSize, ySize);
  }
}

void drawGround() {
  fill(111, 227, 0);
  rect(0, height - grassHeight, width, grassHeight);
  
  for (Bakke bakke : bakker) bakke.display(); 
}
