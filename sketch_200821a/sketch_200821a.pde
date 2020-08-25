/*
Hoppebold projekt.

Fag: Digital Design.
Gruppe: Anders fra L 3d2
Deadline: 25/8-2020 23:00

Beskrivelse af projektet/opgaven:
Mange hoppebolde der kan reflektere på alle vinduets sider samt en bund der ligner jorden (græs og jord)
med en flot baggrund der skal forestille himlen. Disse hoppebolde kan også reflektere på hinanden.
Der er også tyngdekraft der hiver hoppeboldene ned mod jorden, samt friktion på jorden for at få boldene
til at stoppe på et tidspunkt.

Github repository URL: https://github.com/AndysonDK/Hoppebold
*/

HoppeBold hoppeBold;
int randomSeed;

// Programmet fungerer åbenbart ikke hensigtsmæssigt
// når man initialiserer grassHeight variablen inde i setup() metoden  :/
int grassHeight = 7;

Bakke[] bakker = new Bakke[5];
ArrayList<HoppeBold> hoppeBolde;

void setup() {
  size(900, 900);
  randomSeed = int(random(999999999));

  // Lav hoppebold
  hoppeBolde = new ArrayList<HoppeBold>();
  for (int i = 0; i < 10; i++) hoppeBolde.add(new HoppeBold(50, 20, grassHeight));

  // Lav bakker!
  for (int i = 0; i < bakker.length; i++) bakker[i] = new Bakke();
}

void draw() {
  background(25, 170, 229);
  drawNiceBackground();

  // Lopp igennem hver hoppebold og gør følgende:
  // 1.) Opdater dens lokations vektor
  // 2.) Tjek for kollision
  // 3.) Og til sidst vis/tegn hoppebolden
  for (HoppeBold hoppeBold : hoppeBolde) {
    // Jeg bliver nødt til at lave et helt nyt array,
    // så jeg kan fjerne den hoppebold jeg arbejder med lige nu i det nuværende loop
    // da jeg ikke skal bruge den samme hoppebold til at tjekke om jeg har ramt :D
    ArrayList<HoppeBold> hoppeBolde2 = new ArrayList<HoppeBold>(hoppeBolde);
    hoppeBolde2.remove(hoppeBold);

    // Her opdaterer jeg hver hoppebold's lokation og tjekker for dens kollision
    // med alle andre hoppebolde inde i det array der hedder hoppeBolde2.
    // Jeg tjekker også kollision for hver bold og alle bakkerne
    // Til sidst "displayer" jeg dem bare.
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
